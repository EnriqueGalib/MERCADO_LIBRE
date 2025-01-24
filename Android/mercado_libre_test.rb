require 'appium_lib'
require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'fileutils'  # Para manejar la creación de directorios

# Configuración de Appium
caps = {
  platformName: 'Android',
  platformVersion: '15',
  deviceName: 'Medium Phone API 35',
  app: 'C:/Users/Norberto Galicia B/Documents/Mercado_Libre/APK/uptodown-com.mercadolibre.apk',
  automationName: 'UiAutomator2'
}

url = 'http://localhost:4723/wd/hub'
driver = nil

# Crear la carpeta de capturas de pantalla si no existe
screenshots_dir = 'screenshots'
FileUtils.mkdir_p(screenshots_dir) unless Dir.exist?(screenshots_dir)

Given('que la aplicación de Mercado Libre está abierta') do
  driver = Appium::Driver.new({appium_lib: {server_url: url, desired_capabilities: caps}}, true)
  driver.start_driver
end

When('busco {string}') do |search_term|
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  barra_busqueda = wait.until { driver.find_element(id: 'com.mercadolibre:id/ui_components_toolbar_title_toolbar') }
  barra_busqueda.send_keys(search_term)
  barra_busqueda.send_keys(:return)

  # Captura de pantalla después de la búsqueda
  timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
  driver.save_screenshot("#{screenshots_dir}/busqueda_#{timestamp}.png")
end

When('aplico filtros de condición y orden') do
  filtro = driver.find_element(xpath: '//android.widget.TextView[@text="Filtros (3)"]')
  filtro.click
  condiciones = driver.find_element(xpath: '//android.view.View[@content-desc="Condición"]')
  condiciones.click
  nuevo = driver.find_element(xpath: '//android.widget.ToggleButton[@text="Nuevo"]')
  nuevo.click
  ordenar = driver.find_element(xpath: '//android.widget.TextView[@text="Ordenar por "]')
  ordenar.click
  mayor = driver.find_element(xpath: '//android.widget.ToggleButton[@text="Mayor precio"]')
  mayor.click
  ver_resultado = driver.find_element(xpath: '//android.widget.Button[@text="Ver 22 resultados"]')
  ver_resultado.click

  # Captura de pantalla después de aplicar filtros
  timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
  driver.save_screenshot("#{screenshots_dir}/filtros_#{timestamp}.png")
end

Then('debería ver los primeros 5 productos con su nombre y precio') do
  productos = driver.find_elements(id: 'com.mercadolibre:id/search_fragment_container')
  
  productos.take(5).each do |product|
    begin
      nombre_producto = product.find_element(id: 'com.mercadolibre:id/search_cell_title_text_view').text
      precio = product.find_element(id: 'com.mercadolibre:id/search_cell_installments_price_container').text
      puts "#{nombre_producto} - #{precio}"
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      puts "Error al obtener el producto: #{e.message}"
    end
  end

  # Captura de pantalla después de mostrar los productos
  timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
  driver.save_screenshot("#{screenshots_dir}/resultados_#{timestamp}.png")
end

After do
  driver.quit if driver
end