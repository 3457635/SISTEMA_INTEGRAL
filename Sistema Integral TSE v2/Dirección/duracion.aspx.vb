Public Class duracion
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.Year()
        End If
    End Sub

    Protected Sub ibtnActualizar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        Dim ano = CInt(txbAno.Text)
        Dim mes = CInt(ddlMes.SelectedValue)
        
        Dim Rango1 = (From consulta In db.fechas_viajes, consulta2 In db.fechas_facturacions, consulta3 In db.facturacions
            Where consulta.id_viaje = consulta3.id_viaje And
            consulta3.id_factura = consulta2.id_factura And
            consulta2.fecha.tipo_fecha = 7 And
            consulta.fecha.fecha.Value.Month = mes And
            consulta.fecha.fecha.Value.Year = ano And
            (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days >= -1000 And
            (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days <= 15
                       Select via = consulta.id_viaje).Count()
        lnkRango1.Text = Rango1.ToString()

        Dim Rango2 = (From consulta In db.fechas_viajes, consulta2 In db.fechas_facturacions, consulta3 In db.facturacions
            Where consulta.id_viaje = consulta3.id_viaje And
            consulta3.id_factura = consulta2.id_factura And
            consulta2.fecha.tipo_fecha = 7 And
            consulta.fecha.fecha.Value.Month = mes And
            consulta.fecha.fecha.Value.Year = ano And
            (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days >= 16 And
        (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days <= 30
                       Select via = consulta.id_viaje).Count()
        lnkRango2.Text = Rango2.ToString()

        Dim Rango3 = (From consulta In db.fechas_viajes, consulta2 In db.fechas_facturacions, consulta3 In db.facturacions
            Where consulta.id_viaje = consulta3.id_viaje And
            consulta3.id_factura = consulta2.id_factura And
            consulta2.fecha.tipo_fecha = 7 And
            consulta.fecha.fecha.Value.Month = mes And
            consulta.fecha.fecha.Value.Year = ano And
            (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days >= 31 And
        (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days <= 40
                       Select via = consulta.id_viaje).Count()
        lnkRango3.Text = Rango3.ToString()

        Dim Rango4 = (From consulta In db.fechas_viajes, consulta2 In db.fechas_facturacions, consulta3 In db.facturacions
            Where consulta.id_viaje = consulta3.id_viaje And
            consulta3.id_factura = consulta2.id_factura And
            consulta2.fecha.tipo_fecha = 7 And
            consulta.fecha.fecha.Value.Month = mes And
            consulta.fecha.fecha.Value.Year = ano And
            (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days >= 41 And
        (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days <= 50
                       Select via = consulta.id_viaje).Count()

        lnkRango4.Text = Rango4.ToString()

        Dim Rango5 = (From consulta In db.fechas_viajes, consulta2 In db.fechas_facturacions, consulta3 In db.facturacions
            Where consulta.id_viaje = consulta3.id_viaje And
            consulta3.id_factura = consulta2.id_factura And
            consulta2.fecha.tipo_fecha = 7 And
            consulta.fecha.fecha.Value.Month = mes And
            consulta.fecha.fecha.Value.Year = ano And
            (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days >= 51 And
        (consulta2.fecha.fecha - consulta.fecha.fecha).Value.Days < 1000
                       Select via = consulta.id_viaje).Count()

        lnkRango5.Text = Rango5.ToString()
        
        Dim total = (From consulta In db.fechas_viajes, consulta2 In db.fechas_facturacions, consulta3 In db.facturacions
             Where consulta.id_viaje = consulta3.id_viaje And
             consulta3.id_factura = consulta2.id_factura And
             consulta2.fecha.tipo_fecha = 7 And
             consulta.fecha.fecha.Value.Month = mes And
             consulta.fecha.fecha.Value.Year = ano
                                  Select via = consulta.id_viaje).Count()
        lblTotal.Text = total.ToString()

    End Sub

    Protected Sub lnkRango1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango1.Click

        Response.Redirect("duracion_detalle.aspx?Mes=" + ddlMes.SelectedValue + "&Ano=" + txbAno.Text + "&rango1=-1000&rango2=15")
    End Sub

    Protected Sub lnkRango2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango2.Click
        Response.Redirect("duracion_detalle.aspx?Mes=" + ddlMes.SelectedValue + "&Ano=" + txbAno.Text + "&rango1=16&rango2=30")
    End Sub

    Protected Sub lnkRango3_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango3.Click
        Response.Redirect("duracion_detalle.aspx?Mes=" + ddlMes.SelectedValue + "&Ano=" + txbAno.Text + "&rango1=31&rango2=40")
    End Sub

    Protected Sub lnkRango4_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango4.Click
        Response.Redirect("duracion_detalle.aspx?Mes=" + ddlMes.SelectedValue + "&Ano=" + txbAno.Text + "&rango1=41&rango2=50")
    End Sub

    Protected Sub lnkRango5_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango5.Click
        Response.Redirect("duracion_detalle.aspx?Mes=" + ddlMes.SelectedValue + "&Ano=" + txbAno.Text + "&rango1=51&rango2=1000")
    End Sub
End Class