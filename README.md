🍃 Cool Beans
Cool Beans es una aplicación en desarrollo diseñada para los apasionados de la fermentación. En esta plataforma, la idea principal es que los usuarios pueden trackear sus fermentos, y compartir comentarios sobre sus experiencias. Cool Beans busca ser un espacio colaborativo para compartir conocimientos y mejorar las habilidades de fermentación.

🚀 Características actuales
Perfil de usuario: Los usuarios pueden registrarse y personalizar sus perfiles.
Registro de fermentos: Cada usuario puede añadir sus propios fermentos con detalles relevantes como nombre, fecha de inicio, ingredientes, entre otros.
Comentarios: Los usuarios pueden comentar en los fermentos registrados, facilitando el intercambio de ideas, actualizaciones y sugerencias.

🛠️ Tecnologías utilizadas
Este proyecto utiliza el siguiente stack tecnológico:

Backend: Ruby on Rails - Framework principal para la lógica de servidor, API y gestión de la base de datos.
Frontend:
SCSS - Para un diseño y personalización visual más estructurados y eficientes.
Base de datos: PostgreSQL - Para almacenar y gestionar datos de usuarios, fermentos y comentarios.

🎨 Estructura del proyecto

app/controllers: Controladores de Rails para gestionar las rutas y lógica de la aplicación.
app/models: Modelos de Rails que representan y gestionan los datos de cada entidad (usuarios, fermentos, comentarios).
app/views: Vistas de Rails junto con los archivos .html.erb.
app/javascript/controllers: Controladores Stimulus que manejan la interactividad del frontend.
app/assets/stylesheets: Archivos SCSS para el diseño de la interfaz de usuario.

💻 Instalación y configuración
Si deseas ejecutar este proyecto en un entorno local, sigue los pasos:

Clona este repositorio:

```bash
gh repo clone https://github.com/mgd1992/Fermented-Food.git
```
Instala las dependencias de Rails:

```bash
cd FermentApp
bundle install
```
Configura la base de datos:

Crea el archivo config/database.yml (puedes basarte en el archivo config/database.yml.example si está disponible).
Crea y migra la base de datos:
```bash
rails db:create
rails db:migrate
```

Instala las dependencias de JavaScript:

```bash
yarn install
```

Configura las variables de entorno: Crea un archivo .env en la raíz del proyecto y añade las variables necesarias (como las credenciales de la base de datos).

Inicia el servidor de Rails:

```bash
rails s
```
Abre tu navegador y dirígete a http://localhost:3000 para ver la aplicación en funcionamiento.

📈 Próximas mejoras
En próximas versiones, planeamos agregar:

** Galería de imágenes para cada fermento: Para que los usuarios puedan documentar visualmente el progreso de sus fermentos.
** Registro de etapas: Posibilidad de añadir etapas y actualizaciones para cada fermento.
** Sistema de likes y favoritos: Una manera de destacar fermentos populares y permitir a los usuarios guardar sus favoritos.
** Notificaciones en tiempo real: Alertas para nuevos comentarios y actualizaciones en fermentos seguidos.
** Recetas y tutoriales: Sección de aprendizaje para educar a la comunidad en prácticas y recetas de fermentación.

🤝 Contribuciones
¡Las contribuciones son bienvenidas! Para contribuir, sigue estos pasos:

Haz un fork del proyecto.
Crea una rama para tu nueva funcionalidad (git checkout -b feature/nueva-funcionalidad).
Realiza tus cambios y haz commit (git commit -m 'Añadir nueva funcionalidad').
Sube los cambios a tu fork (git push origin feature/nueva-funcionalidad).
Abre un pull request en este repositorio.
📝 Licencia
Este proyecto está bajo la licencia MIT. Puedes consultarla en el archivo LICENSE para más detalles.
