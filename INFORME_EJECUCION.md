# Informe de Ejecución – Examen Práctico de Karate

## 1. Presentación

Como estudiante postulante a un bootcamp, desarrollé esta automatización para practicar pruebas de API con Karate DSL, Java 17, Maven y JUnit 5. El trabajo valida un flujo completo de billetera digital desde la creación de usuarios hasta la revisión de la transferencia por parte del administrador.

## 2. Objetivo

Comprobar que el registro de usuarios, la asignación de saldo, la transferencia y la consulta de operaciones funcionen correctamente. También se busca que las pruebas sean repetibles, claras y que fallen cuando algún dato importante no cumpla con lo esperado.

## 3. Resultados de los escenarios

### Escenario 1: Registro de Usuarios

Se crearon correctamente los usuarios Emisor y Receptor.

Se asignó un saldo inicial de 1000 a cada usuario.

### Escenario 2: Transferencia del Emisor al Receptor

El usuario Emisor inició sesión y realizó una transferencia de 450.00 con la descripción **"Pago de Servicios"**.

Se validó el código de transacción y la disminución del saldo a 550.

### Escenario 3: Validación de Transferencia en el Receptor

El usuario Receptor inició sesión correctamente.

Se validó el incremento del saldo a 1450.

Se verificó la existencia de la transferencia en su historial.

### Flujo Administrador

Se confirmó la operación desde el perfil administrador validando monto, descripción, Emisor y Receptor.

## 4. Resumen de Ejecución

- Escenarios ejecutados: 3
- Escenarios exitosos: 3
- Escenarios fallidos: 0

## Evidencias

- Feature principal: `regresion.feature`
- Feature administrador: `administrador.feature`
- Reporte HTML: `target/karate-reports`
- Reporte JSON: `target/karate-reports`

## 5. Hallazgos

Durante la ejecución no se encontraron errores en el flujo principal probado. Los tres escenarios finalizaron correctamente y las validaciones confirmaron lo siguiente:

- Se generaron números telefónicos diferentes para evitar que los usuarios de prueba se repitieran.
- Los usuarios Emisor y Receptor fueron creados con identificadores y estados válidos.
- El saldo inicial de ambos usuarios fue de 1000.
- La transferencia de 450.00 se realizó con la nota **"Pago de Servicios"**.
- El saldo del Emisor disminuyó correctamente de 1000 a 550.
- El saldo del Receptor aumentó correctamente de 1000 a 1450.
- El código de la transferencia fue encontrado y comparado con el historial del Receptor.
- El administrador pudo consultar y validar la operación, incluyendo monto, descripción, Emisor y Receptor.

Como observación del ambiente, el servicio devuelve el token oculto como `******`. La automatización utiliza ese valor de acuerdo con la respuesta real del API. Esto no impidió completar las pruebas.

## 6. Conclusiones

Considero que el objetivo del examen fue cumplido porque pude automatizar el flujo completo en una sola ejecución y comprobar cada resultado con aserciones. No solo validé los códigos HTTP, sino también los datos de los usuarios, los tokens, los saldos y la información de la transacción.

El uso de `Background` permitió centralizar la configuración común. También utilicé variables reutilizables para conservar los datos del Emisor, Receptor, saldos y código de transacción. Con `call read()` separé las operaciones repetidas en features comunes, lo que hace que el proyecto sea más ordenado y fácil de mantener.

La ejecución terminó con 3 escenarios exitosos y 0 fallidos. Los reportes HTML y JSON generados por Karate sirven como evidencia de la ejecución. Como aprendizaje personal, este ejercicio me ayudó a entender mejor cómo diseñar pruebas de API, validar respuestas completas y organizar una suite de automatización con buenas prácticas.

**Comando ejecutado:**

```
mvn test
```