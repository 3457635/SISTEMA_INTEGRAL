Public Class ctlViajesHechos
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

        total()

        Dim inicio = String.Format("{0} 00:00", txbInicio.Text)
        Dim fin = String.Format("{0} 23:59", txbFin.Text)

        sdsViajesPorCliente.SelectParameters(0).DefaultValue = inicio
        sdsViajesPorCliente.SelectParameters(1).DefaultValue = fin

    End Sub
    Protected Sub total()
        Dim inicio = String.Format("{0} 00:00", txbInicio.Text)
        Dim fin = String.Format("{0} 23:59", txbFin.Text)

        Dim total = (From consulta In db.fechas_viajes
                   Where consulta.viaje.id_status <> 5 And
                   consulta.viaje.id_status <> 3 And
                   consulta.fecha.tipo_fecha = 1 And
                   consulta.fecha.fecha >= inicio And
                   consulta.fecha.fecha <= fin
                   Select consulta.viaje.id_viaje).Count()
        lblTotal.Text = total
    End Sub
   
End Class