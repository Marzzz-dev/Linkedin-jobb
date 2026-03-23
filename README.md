# Update package
pkg update && pkg upgrade -y

# Install python & pip
pkg install python python-pip -y

# Install chrome buat selenium
pkg install chromium -y

# Install git
pkg install git -y

# Install nano (buat edit file)
pkg install nano -y

# Update & install termux dulu
pkg update && pkg upgrade

# Clone repo
git clone https://github.com/Marzzz-dev/Linkedin-jobb.git
cd linkedin-bot

# Jalankan
bash linkedin.sh
