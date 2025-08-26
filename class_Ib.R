# ======================================================
# Project: AI_Omics_Internship_2025 - Module_I
# Script : class_Ib.R
# Author : [Your Name]
# Date   : [Sys.Date()]
# ======================================================

# 1. Set Working Directory -----------------------------------
# Replace with the correct path on your computer
setwd("~/AI_Omics_Internship_2025/Module_I")

# 2. Create project subfolders --------------------------------
folders <- c("raw_data", "clean_data", "scripts", "results", "plots", "tasks")
sapply(folders, function(x) if(!dir.exists(x)) dir.create(x))

# 3. Download dataset from GitHub ------------------------------
# Replace URL with your actual GitHub repo link
#url <- "https://raw.githubusercontent.com/YourUserName/YourRepo/main/patient_info.csv"
#download.file(url, destfile = "raw_data/patient_info.csv", method = "auto")

# 4. Load dataset ----------------------------------------------
patient_info <- read.csv("raw_data/patient_info.csv", stringsAsFactors = FALSE)

# 5. Inspect structure -----------------------------------------
str(patient_info)
summary(patient_info)
head(patient_info)

# 6. Identify incorrect datatypes -------------------------------
# Example: Convert character dates to Date, numeric IDs to factor, etc.
# (You may adjust based on actual dataset inspection)
# Assume: age should be numeric, gender factor, smoker factor

# Convert variables to proper data types
patient_info$age <- as.numeric(patient_info$age)
patient_info$gender <- as.factor(patient_info$gender)
patient_info$smoker <- as.factor(patient_info$smoker)

# 7. Create new binary variable for smoking status --------------
# "Yes" → 1, "No" → 0
patient_info$smoking_status <- ifelse(patient_info$smoker == "Yes", 1, 0)

# 8. Save cleaned dataset ---------------------------------------
write.csv(patient_info, "clean_data/patient_info_clean.csv", row.names = FALSE)

# 9. Save script in scripts folder ------------------------------
# (Manually save this script as "class_Ib.R" inside scripts folder)

# 10. Upload to GitHub ------------------------------------------
# Run these commands in your terminal (not R script):
# git init
# git add scripts/class_Ib.R
# git commit -m "Add class_Ib R script"
# git branch -M main
# git remote add origin https://github.com/YourUserName/YourRepo.git
# git push -u origin main

# ======================================================
# End of Script
# ======================================================
