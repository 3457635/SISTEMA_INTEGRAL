Public Class ctlFacturas
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Dim db As New DataClasses1DataContext()
        Dim fa = From consulta In db.viajes
                       Select consulta
            ''consulta.facturacion.viaje.Ordene.ano,
            ''consulta.facturacion.viaje.Ordene.consecutivo,
            ''consulta.facturacion.viaje.num_viaje,
            ''consulta.facturacion.viaje.precio.precio,
            ''consulta.facturacion.viaje.precio.tipos_moneda
            ''Where consulta.fecha.fecha >= txbInicio.Text AndAlso consulta.fecha.fecha <= txbFin.Text AndAlso consulta.fecha.tipo_fecha = 6 And consulta.facturacion.viaje.precio.id_moneda = 4

        GridView1.DataSource = fa
        GridView1.DataBind()
    End Sub
End Class