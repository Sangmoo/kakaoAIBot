#!/bin/bash

# 스크립트 제목 설정
echo "포트 5000 정리 및 application.py 실행 스크립트"

# 관리자 권한 확인
if [ "$EUID" -ne 0 ]; then
    echo "이 스크립트는 관리자 권한이 필요합니다. sudo로 실행하세요."
    echo "예: sudo ./run_application.sh"
    exit 1
fi

# 포트 5000을 사용하는 프로세스 찾기 및 종료
echo "포트 5000을 사용하는 프로세스를 확인 중..."
pid=$(lsof -t -i :5000 -s TCP:LISTEN)
if [ -n "$pid" ]; then
    echo "포트 5000을 사용하는 프로세스(PID: $pid) 발견. 종료 중..."
    kill -9 $pid
    sleep 2  # 종료 후 잠시 대기
    if ! lsof -i :5000 > /dev/null 2>&1; then
        echo "포트 5000을 사용하는 프로세스가 성공적으로 종료되었습니다."
    else
        echo "포트 5000 종료에 실패했습니다. 수동 확인 필요."
        exit 1
    fi
else
    echo "포트 5000을 사용하는 프로세스가 없습니다."
fi

# application.py 실행 (nohup 사용, 로그 파일로 출력)
echo "application.py를 백그라운드에서 실행 중..."
nohup python -u application.py > application.log 2>&1 &

# 실행 확인
if [ $? -eq 0 ]; then
    echo "application.py가 성공적으로 실행되었습니다. PID: $!"
    echo "로그는 application.log에 저장됩니다. 확인하려면 'tail -f application.log' 실행."
else
    echo "application.py 실행에 실패했습니다. 로그를 확인하세요."
    exit 1
fi

# 재부팅 권장 메시지
echo "변경 사항을 안정적으로 적용하려면 시스템 재부팅을 권장합니다."
echo "스크립트 종료."
exit 0
