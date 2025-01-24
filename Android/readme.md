# Automatización de Búsqueda en la App de Mercado Libre

Este proyecto utiliza Appium y RSpec para automatizar la búsqueda de productos en la aplicación de Mercado Libre en un dispositivo Android. El script busca "PlayStation 5", aplica filtros y obtiene los nombres y precios de los primeros cinco productos mostrados en los resultados.

## Requisitos

- Ruby
- Appium
- RSpec
- Selenium WebDriver
- Un emulador de Android configurado (por ejemplo, Android Studio)
- APK de la aplicación de Mercado Libre

## Instalación

1. **Instalar Ruby**: Asegúrate de tener Ruby instalado en tu sistema. Puedes descargarlo desde [ruby-lang.org](https://www.ruby-lang.org/en/downloads/).

2. **Instalar Appium**: Puedes instalar Appium usando npm. Asegúrate de tener Node.js instalado y ejecuta el siguiente comando:

   ```bash
   npm install -g appium

# Automatización de Búsqueda en la App de Mercado Libre

Este proyecto utiliza Appium y RSpec para automatizar la búsqueda de productos en la aplicación de Mercado Libre en un dispositivo Android.

## Configuración de Appium

A continuación se muestra cómo configurar Appium para la automatización de la aplicación de Mercado Libre.

### Código de Configuración

```ruby
require 'appium_lib'
require 'rspec'

############################ Configuracion de Appium ############################# 
caps = {
  platformName: 'Android',
  platformVersion: '15',
  deviceName: 'Medium Phone API 35', # Nombre del emulador que se creó en Android Studio
  app: 'C:/Users/Norberto Galicia B/Documents/Mercado_Libre/APK/uptodown-com.mercadolibre.apk', # La ruta del APK que se ejecutará 
  automationName: 'UiAutomator2'
}

# Establecer la URL del servidor Appium
url = 'http://localhost:4723/wd/hub'

# Crear un nuevo driver de Appium
begin
  driver = Appium::Driver.new({appium_lib: {server_url: url, desired_capabilities: caps}}, true)

  # Iniciar la sesión
  driver.start_driver

## Pasos para la Búsqueda

### Paso 1: Buscar "PlayStation 5" en la barra de búsqueda de la app

1. **Esperar a que la barra de búsqueda esté presente**:
   ```ruby
   wait = Selenium::WebDriver::Wait.new(timeout: 10) # Espera hasta 10 segundos
   barra_busqueda = wait.until { driver.find_element(id: 'com.mercadolibre:id/ui_components_toolbar_title_toolbar') }
### Paso 2: Ordenar por Filtros

2. **Dar clic en Filtros**:
   ```ruby
   filtro = driver.find_element(xpath: '//android.widget.TextView[@text="Filtros (3)"]')
   filtro.click

### Paso 3: Obtener el nombre y el precio de los primeros 5 productos

3. **Identificar cada producto de la lista**:
   ```ruby
   productos = driver.find_elements(id: 'com.mercadolibre:id/search_fragment_container')
   productos.take(5).each do |product|