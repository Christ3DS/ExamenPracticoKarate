# Informe de Ejecución – Examen Práctico de Karate

## Presentación

Se desarrolló una automatización con Karate DSL para validar el flujo de transferencia entre usuarios y la consulta de la operación desde el perfil administrador.

## Objetivo

Comprobar el correcto funcionamiento del registro de usuarios, transferencia de saldo y validación de transacciones.

## Resultados

### Escenario 1: Registro de Usuarios

Se crearon correctamente los usuarios Emisor y Receptor.

Se asignó un saldo inicial de 1000 a cada usuario.

### Escenario 2: Transferencia

El usuario Emisor inició sesión y realizó una transferencia de 450.00 con la descripción **"Pago de Servicios"**.

Se validó el código de transacción y la disminución del saldo a 550.

### Escenario 3: Validación del Receptor

El usuario Receptor inició sesión correctamente.

Se validó el incremento del saldo a 1450.

Se verificó la existencia de la transferencia en su historial.

### Flujo Administrador

Se confirmó la operación desde el perfil administrador validando monto, descripción, Emisor y Receptor.

## Resumen de Ejecución

- Escenarios ejecutados: 3
- Escenarios exitosos: 3
- Escenarios fallidos: 0

## Evidencias

- Feature principal: `regresion.feature`
- Feature administrador: `administrador.feature`
- Reporte HTML: `target/karate-reports`
- Reporte JSON: `target/karate-reports`

## Conclusiones

La ejecución fue satisfactoria y permitió validar el flujo completo de transferencia de extremo a extremo. Todas las validaciones definidas en los escenarios se ejecutaron correctamente sin errores.

**Comando ejecutado:**

```
mvn test
```