function fn() {
  var ambiente = karate.env || 'qa';
  var host = 'http://134.209.211.10';
  return {
    ambiente: ambiente,
    urlBase: host + ':5173/',
    urlAutenticacion: host + ':4001/auth',
    urlBilletera: host + ':4002/wallet',
    urlTransacciones: host + ':4003/transaction',
    urlAdministrador: host + ':4004/admin',
    montoTransferencia: 450.00,
    notaTransferencia: 'Pago de Servicios',
    generarTelefono: function() {
      return '8' + java.lang.String.valueOf(java.util.concurrent.ThreadLocalRandom.current().nextLong(100000000, 1000000000));
    }
  };
}