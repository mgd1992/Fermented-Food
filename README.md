# 🌿 Cool Beans 🌱

**Cool Beans** es una aplicación web para amantes de la fermentación. Permite a los usuarios registrar sus fermentos, compartir instrucciones detalladas, listar ingredientes, establecer el tiempo estimado de fermentación, subir fotos del proceso y configurar recordatorios por correo para revisar sus fermentos a tiempo.

## Funcionalidades

- Registro y autenticación de usuarios
- Crear, editar y eliminar fermentos
- Instrucciones e ingredientes detallados
- Carga de imágenes de cada fermento
- Recordatorios por correo en fechas clave
- Ver perfiles y fermentos creados por otros usuarios

## Tecnologías utilizadas

- **Backend:** Ruby on Rails
- **Frontend:** Stimulus.js + Bootstrap + SCSS
- **Base de datos:** PostgreSQL
- **Background Jobs:** Sidekiq (para envío de correos y recordatorios)
- **Otros:** ActionMailer, ActiveStorage

## Instalación y uso

### Requisitos

- Ruby 3.3.5
- Rails 7.1.4
- PostgreSQL
- Redis (requerido para Sidekiq)

### Pasos para instalar

1. Clonar el repositorio:

```bash
git clone https://github.com/mgd1992/Fermented-Food.git
cd Fermented-Food
```

2.Instalar las dependencias:

```bash
bundle install
yarn install
```

3. Configurar la base de datos:

```bash
rails db:create
rails db:migrate
```

4. Iniciar el servidor:

```bash
rails s
```

5. Iniciar Sidekiq (en otra terminal):

```bash
bundle exec sidekiq
```

Acceder a la app en:
http://localhost:3000



## Estado del proyecto

🚧 Esta aplicación está en desarrollo, pero ya es funcional.

Me encantaría que la pruebes y me cuentes qué te parece.
Si encontrás errores, tenés ideas para mejorarla o simplemente querés dar tu opinión, cualquier feedback es más que bienvenido.

Podés abrir un issue en este repositorio o contactarme directamente:

- GitHub: [@mgd1992](https://github.com/mgd1992/Fermented-Food)
- Email: marcoogarbini@gmail.com

¡Gracias por tu interés en Cool Beans! 🫘
