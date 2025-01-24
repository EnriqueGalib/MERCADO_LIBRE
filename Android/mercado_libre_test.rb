require 'appium_lib'
require 'rspec'

############################ Configuracion de Appium ############################# 
caps = {
  platformName: 'Android',
  platformVersion: '15',
  deviceName: 'Medium Phone API 35', # Nombre del enmulador que se creo en android studio
  app: 'C:/Users/Norberto Galicia B/Documents/Mercado_Libre/APK/uptodown-com.mercadolibre.apk', #La ruta del apk que se ejecutara 
  automationName: 'UiAutomator2'
}

# Establecer la URL del servidor Appium
url = 'http://localhost:4723/wd/hub'

# Crear un nuevo driver de Appium
begin
  driver = Appium::Driver.new({appium_lib: {server_url: url, desired_capabilities: caps}}, true)

  # Iniciar la sesión
  driver.start_driver


###############################################################
# Paso 1:
#Buscar "playstation 5" en la barra de busqueda de la app
###############################################################


 # Esperar a que la barra de búsqueda esté presente
 wait = Selenium::WebDriver::Wait.new(timeout: 10) # Espera hasta 10 segundos
 barra_busqueda = wait.until { driver.find_element(id: 'com.mercadolibre:id/ui_components_toolbar_title_toolbar') }

 # Buscar Playstation 5
 barra_busqueda.send_keys('playstation 5')
 barra_busqueda.send_keys(:return) 


###############################################################
# Paso 2:
#Ordenar por Filtros
###############################################################

# Dar clic en Filtros
filtro = driver.find_element(xpath: '//android.widget.TextView[@text="Filtros (3)"]')
filtro.click
#Dar clic en Condicion
condiciones = driver.find_element(xpath: '//android.view.View[@content-desc="Condición"]')
condiciones.click
#Dar clic en Nuevo
nuevo = driver.find_element(xpath: '//android.widget.ToggleButton[@text="Nuevo"]')
nuevo.click
#Dar clic en Ordenar
ordenar = driver.find_element(xpath: '//android.widget.TextView[@text="Ordenar por "]')
ordenar.click
#Dar clic boton en Mayor precio a Menor precio
mayor = driver.find_element(xpath: '//android.widget.ToggleButton[@text="Mayor precio"]')
mayor.click
#Dar clic en el boton VER 
ver_resultado = driver.find_element(xpath: '//android.widget.Button[@text="Ver 22 resultados"]')
ver_resultado.click


###############################################################
# Paso 3:
#Obtener el nombre y el precio de los primeros 5 productos que se muestran en los resultados.
#Imprimir estos productos (nombre y precio) en la consola.
###############################################################


#Identificar cada producto de la lista 
 productos = driver.find_elements(id: 'com.mercadolibre:id/search_fragment_container')
 productos.take(5).each do |product|
begin
#Obtener el Nombre y el Precio:
nombre_producto = productos.find_element(id: 'com.mercadolibre:id/search_cell_title_text_view ').text
precio = productos.find_element(id: 'com.mercadolibre:id/search_cell_installments_price_container').text

#Imprimir nombre y precio
puts "#{nombre_producto} - #{precio}"
rescue Selenium::WebDriver::Error::NoSuchElementError => e
  puts "Error al obtener el producto: #{e.message}"
end
end

rescue StandardError => e
puts "Ocurrió un error: #{e.message}"
ensure
# Cerrar el controlador
driver.quit
end