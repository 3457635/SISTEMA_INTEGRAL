Public Class ctlContrarecibo
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        cargar_tabla()
    End Sub
    Protected Sub cargar_tabla()
        Dim Rango1 = (From consulta In db.fechas_facturacions
                     Where Not (From consulta2 In db.fechas_facturacions
                                Where consulta2.fecha.tipo_fecha = 7 Or
                                consulta2.fecha.tipo_fecha = 5
                                Select consulta2.id_factura).Contains(consulta.id_factura) And
                            consulta.factura.importe > 0 And
                            consulta.factura.Cancelada = False And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days >= 0 And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days <= 3 And
                            consulta.fecha.tipo_fecha = 4
                            Select consulta.factura.id_factura).Count()

        lnkRango1.Text = Rango1.ToString()

        Dim Rango2 = (From consulta In db.fechas_facturacions
                     Where Not (From consulta2 In db.fechas_facturacions
                                Where consulta2.fecha.tipo_fecha = 7 Or
                                consulta2.fecha.tipo_fecha = 5
                                Select consulta2.id_factura).Contains(consulta.id_factura) And
                            consulta.factura.importe > 0 And
                            consulta.factura.Cancelada = False And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days >= 4 And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days <= 7 And
                            consulta.fecha.tipo_fecha = 4
                            Select consulta.factura.id_factura).Count()

        lnkRango2.Text = Rango2.ToString()

        Dim Rango3 = (From consulta In db.fechas_facturacions
                     Where Not (From consulta2 In db.fechas_facturacions
                                Where consulta2.fecha.tipo_fecha = 7 Or
                                consulta2.fecha.tipo_fecha = 5
                                Select consulta2.id_factura).Contains(consulta.id_factura) And
                            consulta.factura.importe > 0 And
                            consulta.factura.Cancelada = False And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days >= 8 And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days <= 14 And
        consulta.fecha.tipo_fecha = 4
                            Select consulta.factura.id_factura).Count()

        lnkRango3.Text = Rango3.ToString()

        Dim Rango4 = (From consulta In db.fechas_facturacions
                     Where Not (From consulta2 In db.fechas_facturacions
                                Where consulta2.fecha.tipo_fecha = 7 Or
                                consulta2.fecha.tipo_fecha = 5
                                Select consulta2.id_factura).Contains(consulta.id_factura) And
                            consulta.factura.importe > 0 And
                            consulta.factura.Cancelada = False And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days >= 15 And
                            (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days <= 30 And
                            consulta.fecha.tipo_fecha = 4
                            Select consulta.factura.id_factura).Count()

        lnkRango4.Text = Rango4.ToString()

        Dim Rango5 = (From consulta In db.fechas_facturacions
             Where Not (From consulta2 In db.fechas_facturacions
                        Where consulta2.fecha.tipo_fecha = 7 Or
                        consulta2.fecha.tipo_fecha = 5
                        Select consulta2.id_factura).Contains(consulta.id_factura) And
                    consulta.factura.importe > 0 And
                    consulta.factura.Cancelada = False And
                    (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days > 30 And
                    consulta.fecha.tipo_fecha = 4
                    Select consulta.factura.id_factura).Count()

        lnkRango5.Text = Rango5.ToString()

        Dim total = (From consulta In db.facturas
                     Where Not (From consulta2 In db.fechas_facturacions
                                Where consulta2.fecha.tipo_fecha = 7 Or
                                consulta2.fecha.tipo_fecha = 5
                                Select consulta2.id_factura).Contains(consulta.id_factura) And
                            consulta.importe > 0 And
                            consulta.Cancelada = False
                            Select consulta.id_factura).Count()

        lblTotal.Text = total.ToString()

    End Sub

    Protected Sub lnkRango1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango1.Click
        cargar_grid(0, 3)
    End Sub
    Protected Sub cargar_grid(ByVal rango1 As Integer, ByVal rango2 As Integer)
        Dim Rango = From consulta In db.fechas_facturacions
                    Where Not (From consulta2 In db.fechas_facturacions
                               Where consulta2.fecha.tipo_fecha = 7 Or
                               consulta2.fecha.tipo_fecha = 5
                               Select consulta2.id_factura).Contains(consulta.id_factura) And
                           consulta.factura.importe > 0 And
                           consulta.factura.Cancelada = False And
                           (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days >= rango1 And
                           (Now.Date.AddHours(-7) - consulta.fecha.fecha.Value.Date).Days <= rango2 And
                           consulta.fecha.tipo_fecha = 4
                           Select consulta.id_factura,
                           consulta.factura.folio
                           

        grdContrarecibo.DataSource = Rango
        grdContrarecibo.DataBind()
    End Sub

    Protected Sub lnkRango2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango2.Click
        cargar_grid(4, 7)
    End Sub

    Protected Sub lnkRango3_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango3.Click
        cargar_grid(8, 14)
    End Sub

    Protected Sub lnkRango4_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango4.Click
        cargar_grid(15, 30)
    End Sub

    Protected Sub lnkRango5_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango5.Click
        cargar_grid(31, 5000)
    End Sub

    Protected Sub grdContrarecibo_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdContrarecibo.RowDataBound
       
    End Sub
End Class