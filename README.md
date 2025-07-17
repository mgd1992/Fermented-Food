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

Acceder a la app en:
http://localhost:3000

5. Iniciar Sidekiq (en otra terminal):

```bash
bundle exec sidekiq
```

6. Instalar y correr Redis (necesario para Sidekiq):

```bash
sudo apt update
sudo apt install redis-server
sudo systemctl start redis-server
```


## Probar envío de recordatorios manualmente
Para probar que los recordatorios por email llegan correctamente, podés ejecutar el job manualmente desde la consola de Rails:

1. Abrí la consola de Rails con:

```bash
rails c
```

2. Ejecutá el job que envía los recordatorios:

```bash
ReviewReminderJob.perform_now
```

3. Luego, abrí en tu navegador la URL donde letter_opener muestra los emails generados:

```bash
http://localhost:3000/letter_opener/
```

## Estado del proyecto

🚧 Esta aplicación está en desarrollo, pero ya es funcional.

Me encantaría que la pruebes y me cuentes qué te parece.
Si encontrás errores, tenés ideas para mejorarla o simplemente querés dar tu opinión, cualquier feedback es más que bienvenido.

Podés abrir un issue en este repositorio o contactarme directamente:

- GitHub: [@mgd1992](https://github.com/mgd1992/Fermented-Food)
- Email: marcoogarbini@gmail.com

¡Gracias por tu interés en Cool Beans! 🫘
