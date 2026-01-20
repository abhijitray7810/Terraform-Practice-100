# CloudWatch Logging Setup using Terraform

This project uses **Terraform** to create an **AWS CloudWatch Log Group** and **Log Stream** for the Nautilus DevOps team application.

---

## 📌 Resources Created

The Terraform configuration creates the following AWS resources:

- **CloudWatch Log Group**  
  - Name: `nautilus-log-group`

- **CloudWatch Log Stream**  
  - Name: `nautilus-log-stream`  
  - Associated with: `nautilus-log-group`

---

## 📂 Project Structure

```

/home/bob/terraform
├── main.tf
└── README.md

````

> ⚠️ As per the requirement, only **`main.tf`** is used for Terraform configuration.

---

## ⚙️ Prerequisites

Before running this project, ensure:

- AWS CLI is installed and configured
- Terraform is installed
- Valid AWS credentials with CloudWatch permissions
- AWS Region: `us-east-1`

---

## 🚀 How to Deploy

### Step 1: Navigate to Terraform directory
```bash
cd /home/bob/terraform
````

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Apply the configuration

```bash
terraform apply
```

Type **`yes`** when prompted.

---

## ✅ Verification

After successful execution, verify in AWS Console:

* Go to **CloudWatch → Logs**
* Confirm:

  * Log Group: `nautilus-log-group`
  * Log Stream: `nautilus-log-stream`

---

## 🧹 Cleanup (Optional)

To delete the created resources:

```bash
terraform destroy
```

---

## 🛠 Tools Used

* Terraform
* AWS CloudWatch
* AWS Provider

---

## 📘 Author

Nautilus DevOps Team
Infrastructure managed using **Infrastructure as Code (IaC)** principles.

---

```

---


Just tell me 👍
```
