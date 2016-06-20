Imports DGMC.TimbraCFDI
Public Class ctlCancelarCFDI
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Public Sub limpiarFormulario()
        txbFolio.Text = String.Empty
        lblMensaje.Text = String.Empty
    End Sub
    Public Sub ponerFolio(ByVal folio As String)
        txbFolio.Text = folio
    End Sub
    Public Sub habilitaBoton(ByVal ban As Boolean)
        If ban Then
            btnCancelar.Enabled = True
            lblMensaje.Text = ""
        Else
            btnCancelar.Enabled = False
            lblMensaje.Text = "LA FACTURA YA FUE PAGADA"
        End If
    End Sub
    'Protected Sub btnCancelar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancelar.Click

    '    'En este ejemplo se muestra como cancelar un comprobante xml, previamente timbrado

    '    'Inicializamos el conector' el parámetro indica el ambiente en el que se utilizará 
    '    'Fasle = Ambiente de pruebas
    '    'True = Ambiente de producción
    '    Dim conector As New Conector(True)

    '    'Establecemos las credenciales para el permiso de conexión
    '    'Ambiente de pruebas = mvpNUXmQfK8=
    '    'Ambiente de producción = Esta será asignado por el proveedor al salir a productivo
    '    'Produccion
    '    conector.EstableceCredenciales("jsy+7kNPsnOotlnstxiE6w==")

    '    'pruebas
    '    'conector.EstableceCredenciales("mvpNUXmQfK8=")


    '    'prueba
    '    'Dim rfcEmisor As String = "AAA010101AAA"

    '    'Rfc Emisor
    '    Dim rfcEmisor As String = "CALL630921V68"

    '    'Folio Fiscal - UUID
    '    Dim folioFiscal As String = txbFolio.Text.Trim()

    '    'Obtenemos el xml por medio del conector y guardamos resultado'
    '    Dim resultadoCancelacion As ResultadoCancelacion

    '    resultadoCancelacion = conector.CancelaCFDI(rfcEmisor, folioFiscal)

    '    Dim buscarFactura = (From consulta In db.cfdis
    '                      Where consulta.folioFiscal = txbFolio.Text.Trim()
    '                      Select consulta).FirstOrDefault()

    '    If Not buscarFactura Is Nothing Then
    '        buscarFactura.factura.Cancelada = True
    '        db.SubmitChanges()
    '        lblMensaje.Text = "Cancelacion Exitosa."

    '        'Verificamos el resultado
    '        If (resultadoCancelacion.Exitoso) Then
    '            'El comprobante fue cancelado exitosamente
    '            lblMensaje.Text = resultadoCancelacion.Descripcion
    '        Else
    '            Dim buscarCancelacion = (From consulta In db.cfdiPendienteCancelars
    '                                  Where consulta.idCfdi = buscarFactura.id
    '                                  Select consulta).FirstOrDefault()

    '            If buscarCancelacion Is Nothing Then
    '                Dim nuevaFacturaPendiente As New cfdiPendienteCancelar With {.idCfdi = buscarFactura.id}
    '                db.cfdiPendienteCancelars.InsertOnSubmit(nuevaFacturaPendiente)
    '                db.SubmitChanges()
    '            End If

    '        End If

    '    Else
    '        lblMensaje.Text = "Ocurrió un problema al cancelar."
    '    End If
    'End Sub
    Protected Sub btnCancelar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancelar.Click

        'En este ejemplo se muestra como cancelar un comprobante xml, previamente timbrado

        'Inicializamos el conector' el parámetro indica el ambiente en el que se utilizará 
        'Fasle = Ambiente de pruebas
        'True = Ambiente de producción
        Dim conector As New TSE.Timbrado.Conector(True)

        'prueba()
        'Dim rfcEmisor As String = "AAA010101AAA"

        'Rfc Emisor
        Dim rfcEmisor As String = "CALL630921V68"

        'Folio Fiscal - UUID
        Dim folioFiscal As String = txbFolio.Text.Trim()

        'Obtenemos el xml por medio del conector y guardamos resultado'
        Dim resultadoCancelacion As TSE.Timbrado.ResultadoCancelacion

        resultadoCancelacion = conector.CancelaCFDI(rfcEmisor, folioFiscal)

        Dim buscarFactura = (From consulta In db.cfdis
                          Where consulta.folioFiscal = txbFolio.Text.Trim()
                          Select consulta).FirstOrDefault()
        Dim viaje = (From consulta2 In db.viajes, consulta3 In db.facturacions
                    Where consulta2.id_viaje = consulta3.id_viaje And consulta3.id_factura = buscarFactura.factura.id_factura
                    Select consulta2).FirstOrDefault()


        If Not buscarFactura Is Nothing Then
            buscarFactura.factura.Cancelada = True
            If Not viaje Is Nothing Then
                'Poner en estado no facturado el viaje 
                viaje.facturado = False
                db.SubmitChanges()
            End If
            db.SubmitChanges()
            lblMensaje.Text = "Cancelacion Exitosa."

            'Verificamos el resultado
            If (resultadoCancelacion.Exitoso) Then
                'El comprobante fue cancelado exitosamente
                lblMensaje.Text = resultadoCancelacion.Descripcion
            Else
                Dim buscarCancelacion = (From consulta In db.cfdiPendienteCancelars
                                      Where consulta.idCfdi = buscarFactura.id
                                      Select consulta).FirstOrDefault()

                If buscarCancelacion Is Nothing Then
                    Dim nuevaFacturaPendiente As New cfdiPendienteCancelar With {.idCfdi = buscarFactura.id}
                    db.cfdiPendienteCancelars.InsertOnSubmit(nuevaFacturaPendiente)
                    db.SubmitChanges()
                End If

            End If

        Else
            lblMensaje.Text = "Ocurrió un problema al cancelar."
        End If
    End Sub
End Class