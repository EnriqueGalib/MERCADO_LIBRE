Feature: Buscar productos en Mercado Libre

  Scenario: Buscar y filtrar productos
    Given que la aplicación de Mercado Libre está abierta
    When busco "playstation 5"
    And aplico filtros de condición y orden
    Then debería ver los primeros 5 productos con su nombre y precio