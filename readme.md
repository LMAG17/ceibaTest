# Ceiba iOS test

This Project is developed with iOS (Swift and Storyboard) using an architect like M.V.P. explained below

# Layers
The project is divided into three main layers
  - Services layer: 
    This layer uses ServiceFactory and ServiceInteractor to connect and communicate with JSONPlaceholder Api.
  - Database layer:
    This layer contains the control the transversal database logic of the all application; storing, reading and deleting record in Core Data.
  - Manager layer:
    This layer control the view interaction with data providers (Service and Database) 
  - ViewController layer:
    This layer shows to the user all the application content and handle user actions.

Additional layers
  - Utils layer:
    this layer provides to the application a method to validate network status.

# Ceiba React Native test

Esta prueba esta realizada con iOS (Swift y Storyboard) usando una arquitectura parecida a M.V.P. explicada acontinuacion.

# Capas
El proyecto se divide en tres capas principales
  - Capa de los servicios y el modelo: 
    Esta capa contiene dos archivos, interactor y factory, esos archivos se encargaran de la comunicacion con la api.
  - Capa de base de datos:
    Esta capa tiene la funcion de manejar la logica de base de datos transversal de la aplicacion; almacena, lee y borra los registros en Core Data.
  - Capa de gestores:
    Esta capa se encarga de controlar la interaccion entre la vista y los proveedores de informacion (Servicios y Base de datos)
  - Capa de las vistas:
    Esta capa se encarga de mostrar los datos al usuario y capturar las acciones realizadas.

Capas adicionales
  - Capa de utilidades:
    En esta capa encontraremos un metodo que nos permite validar el estado de la red.
