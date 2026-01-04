# Getting and Cleaning Data - Course Project
# run_analysis.R
# goal: make a tidy dataset from the UCI HAR Dataset

library(dplyr)

# Step 0: download + unzip data

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("UCI HAR Dataset")) {
  download.file(url, destfile = "dataset.zip", mode = "wb")
  unzip("dataset.zip")
}

# Step 1: read files
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
names(activity_labels) <- c("activity_id", "activity_name")

# train
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# test
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")


# Step 2: set column names
colnames(x_train) <- features$V2
colnames(x_test)  <- features$V2

colnames(y_train) <- "activity_id"
colnames(y_test)  <- "activity_id"

colnames(sub_train) <- "subject"
colnames(sub_test)  <- "subject"

# Step 3: merge train + test

train <- cbind(sub_train, y_train, x_train)
test  <- cbind(sub_test,  y_test,  x_test)

full <- rbind(train, test)

# Step 4: keep only mean and std columns
# (and remove meanFreq because not asked usually)

keep <- grepl("mean", names(full), ignore.case = TRUE) |
  grepl("std", names(full), ignore.case = TRUE)

keep <- keep & !grepl("meanFreq", names(full), ignore.case = TRUE)

# always keep subject + activity_id (first 2 cols)
keep[1:2] <- TRUE

data_mean_std <- full[, keep]

# Step 5: use activity names
data_mean_std <- merge(data_mean_std, activity_labels, by = "activity_id")

# put in a nicer order
data_mean_std <- data_mean_std %>%
  select(subject, activity_name, everything()) %>%
  select(-activity_id)

# Step 6: label variables (simple cleanup)
names(data_mean_std) <- gsub("^t", "Time_", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Freq_", names(data_mean_std))
names(data_mean_std) <- gsub("Acc", "Accel", names(data_mean_std))
names(data_mean_std) <- gsub("Gyro", "Gyro", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "Mag", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std) <- gsub("[()\\-]", "", names(data_mean_std))

# Step 7: make second tidy dataset with averages
tidy <- data_mean_std %>%
  group_by(subject, activity_name) %>%
  summarise(across(where(is.numeric), mean), .groups = "drop")

# write result
write.table(tidy, "tidy_data.txt", row.names = FALSE)

# quick checks (optional)
print(dim(tidy))
print(head(tidy))

