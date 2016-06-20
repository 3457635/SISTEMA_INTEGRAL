Imports System.Data.SqlClient
Imports System.Globalization
Public Class facturas_por_cobrar2
    Inherits System.Web.UI.Page
    Dim id_viaje As Integer = 0
    Dim factura As String = ""
    Dim strSQLident As String
    Dim db As New DataClasses1DataContext()
    Dim total_mn As Decimal
    Dim total_dlls As Decimal
    Dim total As Decimal
    Dim importe As Decimal
    Dim retencion As Decimal
    Dim iva As Decimal
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

       
        
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim fecha = txbFecha.Text
        Dim tot = 0.0F
        
        For i = 1 To GridView2.Rows.Count Step 1

            Dim fila = i - 1
            Dim grdFacturas As GridViewRow = GridView2.Rows(fila)
            Dim ckbSeleccionar As CheckBox = grdFacturas.FindControl("ckbFactura")

            Dim seleccionado = CType(GridView2.Rows(fila).FindControl("ckbFactura"), CheckBox).Checked()

           

            If ckbSeleccionar.Checked Then
                Dim idFactura = GridView2.Rows(fila).Cells(0).Text

                If IsNumeric(GridView2.Rows(fila).Cells(9).Text) Then
                    tot += GridView2.Rows(fila).Cells(9).Text
                End If


                Dim buscarFechaPago = (From consulta In db.fechas_facturacions
                                    Where consulta.factura.id_factura = idFactura And
                                    consulta.fecha.tipo_fecha = 7
                                    Select consulta).FirstOrDefault()

                

                If buscarFechaPago Is Nothing Then
                    Dim nuevaFechaPago As New fecha With {.fecha = fecha, .tipo_fecha = 7}
                    Dim nuevaFactuacion As New fechas_facturacion With {.id_factura = idFactura, .fecha = nuevaFechaPago}
                    db.fechas_facturacions.InsertOnSubmit(nuevaFactuacion)
                Else
                    buscarFechaPago.fecha.fecha = fecha
                End If
                db.SubmitChanges()

            End If
        Next
        GridView2.DataBind()
        lblMensaje.Text = String.Format("Listo! Total:{0:c}", tot)
    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        lblMensaje.Text = String.Empty
        Dim tipoConsulta = 1

        buscarFacturas(1)


    End Sub


    

    Protected Sub btnBuscarLote_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscarLote.Click
        lblMensaje.Text = String.Empty
        Dim tipoConsulta = 2
        buscarFacturas(tipoConsulta)

       
    End Sub
    Public Sub buscarFacturas(ByVal tipoConsulta As Integer)

        If tipoConsulta = 1 Then
            Dim inicio = txbInicio.Text
            Dim fin = txbFin.Text
            sdsFacturas.SelectParameters(0).DefaultValue = tipoConsulta
            sdsFacturas.SelectParameters(1).DefaultValue = inicio
            sdsFacturas.SelectParameters(2).DefaultValue = fin
            sdsFacturas.SelectParameters(4).DefaultValue = ddlEmpresas.SelectedValue
        ElseIf tipoConsulta = 2 Then
            Dim idLote = txbLote.Text
            sdsFacturas.SelectParameters(0).DefaultValue = tipoConsulta
            sdsFacturas.SelectParameters(3).DefaultValue = idLote
        ElseIf tipoConsulta = 3 Then
            sdsFacturas.SelectParameters(0).DefaultValue = tipoConsulta
            sdsFacturas.SelectParameters(4).DefaultValue = ddlEmpresas.SelectedValue
        ElseIf tipoConsulta = 4 Then

            Dim fechaInicio = String.Format("{0} 00:00", txbFechaInicio.Text)
            Dim fechaFin = String.Format("{0} 23:59", txbFechaFin.Text)
            Dim tipoFecha = RadioButtonList1.SelectedValue


            sdsFacturas.SelectParameters(0).DefaultValue = tipoConsulta
            sdsFacturas.SelectParameters(4).DefaultValue = ddlEmpresas.SelectedValue
            sdsFacturas.SelectParameters(5).DefaultValue = tipoFecha
            sdsFacturas.SelectParameters(6).DefaultValue = fechaInicio
            sdsFacturas.SelectParameters(7).DefaultValue = fechaFin
        ElseIf tipoConsulta = 5 Then
            sdsFacturas.SelectParameters(0).DefaultValue = tipoConsulta
            sdsFacturas.SelectParameters(4).DefaultValue = ddlEmpresas.SelectedValue
        End If
        GridView2.DataBind()
    End Sub

   

    Protected Sub ckbSeleccionar_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ckbSeleccionar.CheckedChanged
        For i = 0 To GridView2.Rows.Count - 1 Step 1
            Dim grdFacturas As GridViewRow = GridView2.Rows(i)

            Dim ckbFactura As CheckBox = grdFacturas.FindControl("ckbFactura")

            If ckbFactura.Checked Then
                ckbFactura.Checked = False
            Else
                ckbFactura.Checked = True
            End If

        Next
    End Sub

    
    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim idFactura = e.Row.Cells(0).Text

            Me.importe += e.Row.Cells(6).Text
            Me.iva += e.Row.Cells(7).Text

            If IsNumeric(e.Row.Cells(8).Text) Then
                Me.retencion += e.Row.Cells(8).Text
            End If

            Me.total += e.Row.Cells(9).Text

            Dim sdsViajes As SqlDataSource = CType(e.Row.FindControl("sdsViajes"), SqlDataSource)
            Dim sdsCajas As SqlDataSource = CType(e.Row.FindControl("sdsCajas"), SqlDataSource)
            Dim lblPromesa As Label = CType(e.Row.FindControl("lblPromesa"), Label)


            Dim buscarFechaPromesa = (From consulta In db.fechas_facturacions
                            Where consulta.id_factura = idFactura And
                            consulta.fecha.tipo_fecha = 6
                            Select consulta).FirstOrDefault()

            If Not buscarFechaPromesa Is Nothing Then
                lblPromesa.Text = String.Format("{0:d}", buscarFechaPromesa.fecha.fecha)
            End If


            Dim buscarFecha = (From consulta In db.fechas_facturacions
                            Where consulta.id_factura = idFactura And
                            consulta.fecha.tipo_fecha = 7
                            Select consulta).FirstOrDefault()

            sdsViajes.SelectParameters(0).DefaultValue = idFactura
            sdsCajas.SelectParameters(0).DefaultValue = idFactura

            If Not buscarFecha Is Nothing Then
                Dim lblFecha = CType(e.Row.FindControl("lblFecha"), Label)
                lblFecha.Text = buscarFecha.fecha.fecha
                'Dim ckbFactura = CType(e.Row.FindControl("ckbFactura"), CheckBox)
                'ckbFactura.Checked = True
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(6).Text = String.Format("{0:c}", Me.importe)
            e.Row.Cells(7).Text = String.Format("{0:c}", Me.iva)
            e.Row.Cells(8).Text = String.Format("{0:c}", Me.retencion)
            e.Row.Cells(9).Text = String.Format("{0:c}", Me.total)

        End If
    End Sub

    Protected Sub btnGuardarPromesa_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarPromesa.Click
        Dim fecha = txbPromesaPago.Text

        Dim tot = 0.0F

        For i = 1 To GridView2.Rows.Count Step 1

            Dim fila = i - 1
            Dim grdFacturas As GridViewRow = GridView2.Rows(fila)
            Dim ckbSeleccionar As CheckBox = grdFacturas.FindControl("ckbFactura")

            Dim seleccionado = CType(GridView2.Rows(fila).FindControl("ckbFactura"), CheckBox).Checked()

            If ckbSeleccionar.Checked Then
                Dim idFactura = GridView2.Rows(fila).Cells(0).Text

                tot += GridView2.Rows(fila).Cells(9).Text

                Dim buscarFechaPromesaPago = (From consulta In db.fechas_facturacions
                                    Where consulta.factura.id_factura = idFactura And
                                    consulta.fecha.tipo_fecha = 6
                                    Select consulta).FirstOrDefault()

                If buscarFechaPromesaPago Is Nothing Then
                    Dim nuevaFechaPromesaPago As New fecha With {.fecha = fecha, .tipo_fecha = 6}
                    Dim nuevaFactuacion As New fechas_facturacion With {.id_factura = idFactura, .fecha = nuevaFechaPromesaPago}
                    db.fechas_facturacions.InsertOnSubmit(nuevaFactuacion)
                Else
                    buscarFechaPromesaPago.fecha.fecha = fecha
                End If
                db.SubmitChanges()

            End If
        Next
        GridView2.DataBind()
        lblMensaje.Text = String.Format("Listo!  Total: {0:c}", tot)
    End Sub

    Protected Sub lnkSaldo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSaldo.Click
        lblMensaje.Text = String.Empty
        Dim tipoConsulta = 3
        buscarFacturas(tipoConsulta)
    End Sub

    Protected Sub btnIngresado_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnIngresado.Click
        If IsDate(txbFechaInicio.Text) And IsDate(txbFechaFin.Text) Then
            buscarFacturas(4)
        End If



    End Sub

    Protected Sub lnkRetraso_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRetraso.Click
        buscarFacturas(5)
    End Sub

    Protected Sub btnConsultar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnConsultar.Click
        
    End Sub
End Class