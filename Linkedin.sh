#!/bin/bash
# ============================================
# LINKEDIN AUTO APPLY BOT v3.0
# Author: @Whois_Marzz
# auto Job aply di linkedin wok 😹, boleh di fork trus di rinem
# ============================================

R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
B='\033[0;34m'
C='\033[0;36m'
W='\033[1;37m'
N='\033[0m'

banner() {
    clear
    echo -e "${C}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║  ██╗     ██╗███╗   ██╗██╗  ██╗███████╗██████╗ ██╗███╗   ██╗║"
    echo "║  ██║     ██║████╗  ██║██║ ██╔╝██╔════╝██╔══██╗██║████╗  ██║║"
    echo "║  ██║     ██║██╔██╗ ██║█████╔╝ █████╗  ██║  ██║██║██╔██╗ ██║║"
    echo "║  ██║     ██║██║╚██╗██║██╔═██╗ ██╔══╝  ██║  ██║██║██║╚██╗██║║"
    echo "║  ███████╗██║██║ ╚████║██║  ██╗███████╗██████╔╝██║██║ ╚████║║"
    echo "║  ╚══════╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝╚═╝  ╚═══╝║"
    echo "║                                                           ║"
    echo "║              AUTO APPLY BOT v3.0 - TERMUX                 ║"
    echo "║               Created by @Whois_Marzz                     ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${N}"
}

menu() {
    banner
    echo -e "${Y}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                      MAIN MENU                           ║"
    echo "╠═══════════════════════════════════════════════════════════╣"
    echo "║  ${G}[1]${W} 🚀 Start Bot                                          ║"
    echo "║  ${G}[2]${W} ⚙️  Configure Role                                    ║"
    echo "║  ${G}[3]${W} 👤 Edit Credentials                                   ║"
    echo "║  ${G}[4]${W} 📊 View Report                                        ║"
    echo "║  ${G}[5]${W} 🔧 Install Dependencies                               ║"
    echo "║  ${G}[6]${W} 🎯 Change Bot Name                                    ║"
    echo "║  ${R}[0]${W} 🚪 Exit                                              ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${N}"
}

# ==================== INSTALL DEPENDENCIES ====================
install_deps() {
    clear
    echo -e "${Y}[+] Installing dependencies...${N}"
    pkg update -y
    pkg install -y python python-pip chromium
    pip install selenium webdriver-manager pandas
    python -c "from webdriver_manager.chrome import ChromeDriverManager; ChromeDriverManager().install()" 2>/dev/null
    echo -e "${G}[✓] Installation complete!${N}"
    read -p "Press Enter..."
}

# ==================== CONFIGURE ROLE ====================
configure_role() {
    clear
    echo -e "${C}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                 SELECT YOUR ROLE                         ║"
    echo "╠═══════════════════════════════════════════════════════════╣"
    echo "║  ${G}[1]${W} 🛡️  Cyber Security / Ethical Hacker                ║"
    echo "║  ${G}[2]${W} 💻 Software Engineer                               ║"
    echo "║  ${G}[3]${W} 🌐 Full Stack Developer                           ║"
    echo "║  ${G}[4]${W} 🎨 Frontend Developer                              ║"
    echo "║  ${G}[5]${W} ⚙️  Backend Developer                               ║"
    echo "║  ${G}[6]${W} 🤖 AI / ML Engineer                                 ║"
    echo "║  ${G}[7]${W} ☁️  DevOps Engineer                                 ║"
    echo "║  ${G}[8]${W} 📊 Data Scientist                                   ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${N}"
    read -p "Pilih role [1-8]: " role_choice
    case $role_choice in
        1) ROLE="cyber_security" ;;
        2) ROLE="software_engineer" ;;
        3) ROLE="fullstack" ;;
        4) ROLE="frontend" ;;
        5) ROLE="backend" ;;
        6) ROLE="ai_engineer" ;;
        7) ROLE="devops" ;;
        8) ROLE="data_scientist" ;;
        *) ROLE="cyber_security" ;;
    esac
    echo "$ROLE" > ~/.linkedin_role
    echo -e "${G}[✓] Role set to: $ROLE${N}"
    read -p "Press Enter..."
}

# ==================== EDIT CREDENTIALS ====================
edit_credentials() {
    clear
    echo -e "${Y}[+] Edit LinkedIn Credentials${N}"
    echo ""
    read -p "Email: " email
    read -sp "Password: " password
    echo ""
    echo "$email" > ~/.linkedin_email
    echo "$password" > ~/.linkedin_pass
    chmod 600 ~/.linkedin_pass
    echo -e "${G}[✓] Credentials saved!${N}"
    read -p "Press Enter..."
}

# ==================== VIEW REPORT ====================
view_report() {
    clear
    echo -e "${C}[+] Recent Reports${N}"
    echo ""
    ls -la linkedin_applied_*.csv 2>/dev/null | tail -5
    echo ""
    read -p "Enter report name to view (or Enter to skip): " report
    [ -f "$report" ] && cat "$report" | head -20
    read -p "Press Enter..."
}

# ==================== CHANGE BOT NAME ====================
change_name() {
    clear
    echo -e "${Y}[+] Change Bot Name${N}"
    echo "Current name: linkedin_bot.py"
    read -p "New name (without .py): " new_name
    if [ -f "linkedin_bot.py" ]; then
        mv linkedin_bot.py "${new_name}.py"
        echo -e "${G}[✓] Bot renamed to: ${new_name}.py${N}"
    fi
    read -p "Press Enter..."
}

# ==================== CREATE BOT SCRIPT ====================
create_bot() {
    cat > linkedin_bot.py << 'PYEOF'
#!/usr/bin/env python3
# LINKEDIN AUTO APPLY BOT v3.0
# Created by @Whois_Marzz

import time
import os
import random
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from datetime import datetime

def load_credentials():
    try:
        with open(os.path.expanduser("~/.linkedin_email")) as f: email = f.read().strip()
        with open(os.path.expanduser("~/.linkedin_pass")) as f: password = f.read().strip()
        return email, password
    except: return None, None

def load_role():
    try:
        with open(os.path.expanduser("~/.linkedin_role")) as f: return f.read().strip()
    except: return "cyber_security"

ROLES = {
    "cyber_security": {"name": "Cyber Security", "keywords": ["cyber security", "security analyst", "penetration tester", "ethical hacker"], "skills": ["network security", "penetration testing", "firewall", "SIEM", "Nmap", "Metasploit"]},
    "software_engineer": {"name": "Software Engineer", "keywords": ["software engineer", "software developer"], "skills": ["python", "java", "javascript", "git", "sql"]},
    "fullstack": {"name": "Full Stack", "keywords": ["full stack", "fullstack"], "skills": ["react", "node.js", "python", "javascript", "html", "css"]},
    "frontend": {"name": "Frontend", "keywords": ["frontend", "front-end"], "skills": ["react", "angular", "javascript", "html", "css"]},
    "backend": {"name": "Backend", "keywords": ["backend", "back-end"], "skills": ["python", "java", "node.js", "sql", "docker"]},
    "ai_engineer": {"name": "AI Engineer", "keywords": ["ai engineer", "machine learning"], "skills": ["python", "tensorflow", "pytorch", "langchain"]},
    "devops": {"name": "DevOps", "keywords": ["devops", "sre"], "skills": ["docker", "kubernetes", "aws", "terraform", "linux"]},
    "data_scientist": {"name": "Data Scientist", "keywords": ["data scientist", "data analyst"], "skills": ["python", "pandas", "sql", "machine learning"]}
}

class LinkedInBot:
    def __init__(self):
        self.email, self.pwd = load_credentials()
        self.role = load_role()
        self.cfg = ROLES.get(self.role, ROLES["cyber_security"])
        self.applied = 0
        self.results = []
        
    def setup_driver(self):
        opts = webdriver.ChromeOptions()
        opts.add_argument("--headless")
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--disable-blink-features=AutomationControlled")
        try:
            from webdriver_manager.chrome import ChromeDriverManager
            self.driver = webdriver.Chrome(ChromeDriverManager().install(), options=opts)
        except:
            self.driver = webdriver.Chrome(options=opts)
            
    def login(self):
        print("[+] Logging in...")
        self.driver.get("https://www.linkedin.com/login")
        WebDriverWait(self.driver, 10).until(EC.presence_of_element_located((By.ID, "username"))).send_keys(self.email)
        self.driver.find_element(By.ID, "password").send_keys(self.pwd + Keys.RETURN)
        time.sleep(3)
        print("[+] Login OK")
        
    def match_skills(self, desc):
        desc = desc.lower()
        matched = [s for s in self.cfg["skills"] if s.lower() in desc]
        percent = (len(matched) / len(self.cfg["skills"])) * 100 if self.cfg["skills"] else 0
        return percent, matched
        
    def search_jobs(self):
        jobs = []
        for kw in self.cfg["keywords"][:2]:
            print(f"[+] Searching: {kw}")
            url = f"https://www.linkedin.com/jobs/search/?keywords={kw.replace(' ', '%20')}&location=Indonesia&f_WT=2&f_AL=true"
            self.driver.get(url)
            time.sleep(2)
            try:
                cards = WebDriverWait(self.driver, 10).until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".job-card-container")))
                for card in cards[:25]:
                    try:
                        title = card.find_element(By.CSS_SELECTOR, ".job-card-list__title").text
                        company = card.find_element(By.CSS_SELECTOR, ".job-card-container__company-name").text
                        link = card.find_element(By.CSS_SELECTOR, "a").get_attribute("href")
                        jobs.append({"title": title, "company": company, "link": link})
                    except: pass
            except: pass
        return jobs
        
    def apply_job(self, job):
        try:
            self.driver.get(job["link"])
            time.sleep(2)
            btns = self.driver.find_elements(By.CSS_SELECTOR, ".jobs-apply-button")
            if not btns: return False
            btns[0].click()
            time.sleep(2)
            for _ in range(5):
                next_btns = self.driver.find_elements(By.CSS_SELECTOR, ".artdeco-button--primary")
                if not next_btns: break
                if "submit" in next_btns[0].text.lower():
                    next_btns[0].click()
                    break
                next_btns[0].click()
                time.sleep(1)
            return "submitted" in self.driver.page_source.lower()
        except: return False
        
    def run(self):
        if not self.email:
            print("[!] Credentials not set!")
            return
        print(f"[+] Role: {self.cfg['name']}")
        print(f"[+] Skills: {len(self.cfg['skills'])}")
        
        self.setup_driver()
        self.login()
        jobs = self.search_jobs()
        print(f"[+] Found {len(jobs)} jobs")
        
        for job in jobs:
            print(f"\n[+] {job['title']} at {job['company']}")
            self.driver.get(job["link"])
            time.sleep(2)
            match, skills, applied = 0, [], False
            try:
                desc = self.driver.find_element(By.CSS_SELECTOR, ".jobs-description-content__text").text
                match, skills = self.match_skills(desc)
                print(f"    Match: {match:.0f}% ({len(skills)} skills)")
                if match >= 50:
                    print("    Applying...")
                    applied = self.apply_job(job)
                    if applied: 
                        self.applied += 1
                        print("    ✓ Applied!")
                    else: 
                        print("    ✗ Failed")
                else:
                    print("    ✗ Low match, skip")
            except: pass
            
            self.results.append({
                "title": job["title"],
                "company": job["company"],
                "link": job["link"],
                "skill_match": round(match, 1),
                "matched_skills": ", ".join(skills[:3]),
                "applied": "YES" if applied else "NO",
                "time": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            })
            time.sleep(30)
            
        filename = f"linkedin_applied_{self.role}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
        with open(filename, "w") as f:
            f.write("title,company,link,skill_match,matched_skills,applied,time\n")
            for r in self.results:
                f.write(f'"{r["title"]}","{r["company"]}","{r["link"]}",{r["skill_match"]},"{r["matched_skills"]}",{r["applied"]},"{r["time"]}"\n')
        
        print(f"\n[+] Applied: {self.applied}/{len(jobs)}")
        print(f"[+] Report: {filename}")
        self.driver.quit()

if __name__ == "__main__":
    bot = LinkedInBot()
    bot.run()
PYEOF
    chmod +x linkedin_bot.py
    echo -e "${G}[✓] Bot created!${N}"
}

# ==================== START BOT ====================
start_bot() {
    clear
    if [ ! -f ~/.linkedin_email ] || [ ! -f ~/.linkedin_pass ]; then
        echo -e "${R}[!] Credentials not set! Use menu 3 first.${N}"
        read -p "Press Enter..."
        return
    fi
    [ ! -f linkedin_bot.py ] && create_bot
    python linkedin_bot.py
    read -p "Press Enter..."
}

# ==================== MAIN ====================
while true; do
    menu
    read -p "Pilih [0-6]: " c
    case $c in
        1) start_bot ;;
        2) configure_role ;;
        3) edit_credentials ;;
        4) view_report ;;
        5) install_deps ;;
        6) change_name ;;
        0) echo -e "${G}Bye!${N}"; exit 0 ;;
        *) echo -e "${R}Pilihan salah!${N}" ;;
    esac
done
