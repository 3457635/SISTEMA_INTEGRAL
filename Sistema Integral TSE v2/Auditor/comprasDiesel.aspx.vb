Public Class comprasDiesel
    Inherits System.Web.UI.Page
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year
            actualizarIndicadores()
        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim nuevaCompra As New wcfRef1.comprasDiesel()

        Dim fecha = String.Format("{0} {1}", txbFecha.Text, txbHora.Text)

        nuevaCompra.comentarios = txbComentarios.Text
        nuevaCompra.comprobante = txbFactura.Text
        nuevaCompra.litrosComprados = txbLitrosComprados.Text
        nuevaCompra.litrosEnTanque = txbLitrosTanque.Text
        nuevaCompra.fecha = fecha
        nuevaCompra.idProveedor = ddlProveedor.SelectedValue
        Try
            proxy.crearCompraDiesel(nuevaCompra)
            lblMensaje.Text = "Listo!"
            actualizarIndicadores()
            sdsCompras.DataBind()
        Catch ex As Exception
            lblMensaje.Text = ex.Message
        End Try

        

    End Sub

    Public Sub actualizarIndicadores()


        Dim hoy = Now.AddHours(-7)
        Dim ultimaCompra = proxy.buscarUltimaCompraDiesel(hoy)

        If Not ultimaCompra Is Nothing Then
            Dim fechaUltimaCompra = ultimaCompra.fecha

            Dim recargasInternas = proxy.regresarLtsIntPorFechas(fechaUltimaCompra, hoy)

            Dim ltsUltimaCompra = ultimaCompra.litrosComprados + ultimaCompra.litrosEnTanque

            Dim ltsEnTanque = ltsUltimaCompra - recargasInternas

            lblExcistencia.Text = ltsEnTanque
            lblConsumo.Text = recargasInternas
            lblLtsInicio.Text = ltsUltimaCompra


        Else
            txbLitrosTanque.Text = 0
        End If

    End Sub

    Protected Sub txbHora_TextChanged(sender As Object, e As EventArgs) Handles txbHora.TextChanged
        Dim fecha = String.Format("{0} {1}", txbFecha.Text, txbHora.Text)

        Dim ultimaCompra = proxy.buscarUltimaCompraDiesel(fecha)

        If Not ultimaCompra Is Nothing Then
            Dim fechaUltimaCompra = ultimaCompra.fecha

            Dim recargasInternas = proxy.regresarLtsIntPorFechas(fechaUltimaCompra, fecha)


            Dim ltsUltimaCompra = ultimaCompra.litrosComprados + ultimaCompra.litrosEnTanque

            Dim ltsEnTanque = ltsUltimaCompra - recargasInternas

            txbLitrosTanque.Text = ltsEnTanque



        Else
            txbLitrosTanque.Text = 0
        End If


    End Sub
End Class