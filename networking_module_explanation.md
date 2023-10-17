
# Networking en Terraform para AWS

## VPC (Virtual Private Cloud)

```hcl
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}
```

Aquí estás creando una VPC con un bloque CIDR definido en una variable. Además, estás habilitando el soporte DNS y los nombres de host DNS dentro de la VPC. La VPC es esencialmente tu red virtual privada en AWS que te permite aislar recursos y definir tu propio espacio de red.

## Subnets (Subredes)

```hcl
resource "aws_subnet" "public" {
  ...
}

resource "aws_subnet" "private" {
  ...
}
```

Estás definiendo dos subredes, una pública y una privada. Las subredes te permiten segmentar tu VPC en redes más pequeñas. La subred pública suele tener acceso directo a Internet a través de un Internet Gateway, mientras que la subred privada no tiene acceso directo, pero podría acceder a Internet a través de un NAT Gateway.

## Security Groups (Grupos de seguridad)

```hcl
resource "aws_security_group" "allow_all" {
  ...
}

resource "aws_security_group" "eks_sg" {
  ...
}
```

Los grupos de seguridad actúan como un firewall virtual para tus instancias, permitiendo definir reglas de entrada y salida. Tienes dos grupos de seguridad definidos: uno que permite todo el tráfico (`allow_all`) y otro específico para tu clúster EKS (`eks_sg`).

## Security Group Rules (Reglas de grupos de seguridad)

```hcl
resource "aws_security_group_rule" "eks_cluster_ingress_from_nodes" {
  ...
}
```

Estás definiendo varias reglas para especificar qué tráfico está permitido entre tus grupos de seguridad y posiblemente otras direcciones IP. Por ejemplo, con estas reglas, estás permitiendo el tráfico entre el grupo de seguridad `eks_sg` y el grupo de seguridad `allow_all`.

## SSH Access (Acceso SSH)

```hcl
resource "aws_security_group_rule" "allow_ssh" {
  ...
}
```

Esta regla te permite acceder a las instancias dentro de tu VPC mediante SSH. Estás permitiendo el tráfico SSH desde cualquier dirección IP (`0.0.0.0/0`). Aunque esto es útil para pruebas, es importante restringir este acceso en entornos de producción.

