# Jenkins + Docker + Terraform + AWS (IaC Pipeline)

Este proyecto implementa una infraestructura mínima en AWS usando Terraform de forma modular, orquestada a través de Jenkins y Docker.

---

## 🧩 ¿Qué hace este proyecto?

- Lanza una instancia EC2 en AWS.
- Instala automáticamente Docker y Jenkins en la máquina.
- Usa infraestructura como código (IaC) con módulos reutilizables en Terraform.
- Permite aplicar o destruir la infraestructura desde una interfaz Jenkins.

---

## 🚀 Stack utilizado

| Herramienta   | Propósito                            |
|---------------|--------------------------------------|
| Terraform     | Infraestructura como código          |
| Jenkins       | Automatización CI/CD                 |
| Docker        | Contenedor para Jenkins              |
| AWS (EC2, VPC, SG, etc.) | Provisión cloud           |

---


## ✅ Requisitos previos

- Cuenta en AWS con permisos para EC2, VPC, Security Groups.
- Jenkins configurado con:
  - Plugin de AWS Credentials
  - Docker instalado
  - Credential ID: `aws-credentials` con access/secret key
- Clave SSH creada en AWS (`mi-clave-ssh`) y registrada en tu cuenta.

---

## ⚙️ Cómo usar el pipeline en Jenkins

1. Clona este repositorio en una nueva pipeline.
2. En el panel de Jenkins, selecciona la acción: `Deploy` o `Destroy`.
3. Ejecuta el pipeline.
4. El pipeline realizará:
   - `terraform init`
   - `terraform validate`
   - `terraform plan` y `apply` o `destroy`

---

## 📦 Detalles técnicos

- **AMI usada:** Amazon Linux 2023
- **Puerto expuesto:** 8080 (Jenkins)
- **SSH habilitado:** puerto 22 (ajustable en `security.tf`)
- **Región por defecto:** `us-east-1` (modificable)

---

## 🔒 Seguridad

- La instancia tiene acceso SSH abierto (`0.0.0.0/0`) solo para fines de laboratorio.
- En producción se recomienda restringir IPs en el Security Group.

---


---

## ✉️ Autor

**Santiago (peporerto)**  
⚒️ Backend Dev | 🛠️ Infra Cloud Dev  
📍 Basado en Toronto, Canadá  
📬 GitHub: [@peporerto](https://github.com/peporerto)

---

