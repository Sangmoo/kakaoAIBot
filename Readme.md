
# EC2 설정
https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/EC2_GetStarted.html
- Amazon Linux 를 사용하기에는 Bastion 서버를 사용하지 않으면, Pem | Ppk 파일로 직접 접근이 불가능하기 때문에 Ubuntu로 생성
- AMI - Ubuntu Server 24.04 LTS (HVM),EBS General Purpose (SSD) Volume Type
- Instance Type - t3.micro
- Key Pair 생성
- 네트워크 설정 - Public 구성의 VPC 생성
- 퍼블릭 IP 자동 할당 - 활성화
- 방화벽(보안 그룹) - 기존 보안 그룹 선택
- 인바운드 규칙은 사용할 포트, FTP, SSH로 구성

# EC2 설정 참고
https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/ec2-key-pairs.html

# EC2 시작 이후 설정
init.sh 실행 - 참고

# 시스템 패키지 사용 금지
python -m pip config set global.break-system-packages true 

# Run
chmod +x run_application.sh
sudo ./run_application.sh

로그 확인: tail -f application.log
프로세스 확인: ps aux | grep python