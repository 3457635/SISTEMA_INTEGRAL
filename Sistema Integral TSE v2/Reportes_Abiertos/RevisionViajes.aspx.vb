Imports System.IO

Imports System.Data

Public Class RevisionViajes
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.Year()
            llenarGrid()
        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

        ' Verifies that the control is rendered
    End Sub


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsChoferes As SqlDataSource = CType(e.Row.FindControl("sdsChoferes"), SqlDataSource)
            Dim grdUnidad As GridView = CType(e.Row.FindControl("Gridview3"), GridView)
            Dim grdCaja As GridView = CType(e.Row.FindControl("Gridview4"), GridView)
            Dim grdTrayecto As GridView = CType(e.Row.FindControl("Gridview5"), GridView)
            Dim id_viaje As Label = CType(e.Row.FindControl("lblIdViaje"), Label)
            Dim lblRecolecciones As Label = CType(e.Row.FindControl("lblRecolecciones"), Label)

            Dim costo_total As Decimal = 0

            Dim lblFactura As SqlDataSource = CType(e.Row.FindControl("sdsFactura"), SqlDataSource)
            lblFactura.SelectParameters(0).DefaultValue = id_viaje.Text

            Dim fecha_servicio = e.Row.Cells(7).Text
            Dim orden = (From consulta In db.viajes
                      Where consulta.id_viaje = id_viaje.Text
                      Select consulta.id_orden).FirstOrDefault()

            sdsChoferes.SelectParameters(0).DefaultValue = id_viaje.Text

            Dim Imagen_cancelada As Image = CType(e.Row.FindControl("image1"), Image)

            Dim cancelada = (From consulta In db.viajes
                            Where consulta.id_viaje = id_viaje.Text
                            Select consulta.id_status).FirstOrDefault()

            If cancelada <> 5 And cancelada <> 3 Then
                Imagen_cancelada.Visible = False
            Else
                Imagen_cancelada.Visible = True
            End If

            Dim _recolecciones = (From consulta In db.recolecciones
                              Where consulta.id_viaje = id_viaje.Text
                              Select consulta.recolecciones).FirstOrDefault()

            If Not _recolecciones Is Nothing Then
                lblRecolecciones.Text = _recolecciones.ToString()
            End If

            Dim unidad = From consulta In db.equipo_asignados
                       Where consulta.ViajeId = id_viaje.Text And
                       consulta.equipo_operacion.id_tipo_equipo <> 107
                       Select consulta.equipo_operacion.economico,
                       consulta.equipo_operacion.tipo_equipo.equipo

            grdUnidad.DataSource = unidad
            grdUnidad.DataBind()
            'modificacion para buscar la caja en equipo_operacion 04 -08-2015 jose pallares editado 14 ago 2015 para obtenerlo bien
            Dim caja = (From consulta In db.cajaAsignadas
                       Where consulta.equipo_asignado.ViajeId = id_viaje.Text
            Select consulta.CajaId).FirstOrDefault()

            Dim cajaEconomico = From consulta In db.equipo_operacions
                                Where consulta.id_equipo = caja
                                Select consulta.economico
            'Dim cajaEo = From consulta2 In db.equipo_operacions
            '            Where consulta2.id_equipo = cajaASid_equipo
            '            Select consulta2.economico
            '-----------------------------------------------------------------------------------------------------
            grdCaja.DataSource = cajaEconomico
            grdCaja.DataBind()

            Dim trayecto_asignado = From consulta In db.trayectos_asignados
                      Where consulta.equipo_asignado.ViajeId = id_viaje.Text
                      Select consulta.llave_trayecto.trayecto

            grdTrayecto.DataSource = trayecto_asignado
            grdTrayecto.DataBind()

        End If
    End Sub



    Protected Sub CheckBox1_CheckedChanged1(ByVal sender As Object, ByVal e As EventArgs)


        Dim chkResponsable As CheckBox = CType(sender, CheckBox)
        Dim gvrFilaActual As GridViewRow = DirectCast(DirectCast(chkResponsable.Parent, DataControlFieldCell).Parent, GridViewRow)
        Dim _id_viaje = DirectCast(gvrFilaActual.Cells(0).FindControl("lblIdViaje"), Label).Text

        Dim viaje_revisado = proxy.buscarViajePorId(_id_viaje)

        If Not viaje_revisado Is Nothing Then


            If User.IsInRole("Facturacion") Or User.IsInRole("administrador") Then

                If viaje_revisado.verificado Then
                    viaje_revisado.verificado = False
                Else
                    viaje_revisado.verificado = True
                End If
                proxy.actualizarViaje(viaje_revisado)
            Else
                lblMensaje.Text = "Usted no tiene privilegios suficientes."

            End If

            If String.IsNullOrEmpty(txbFechaInicio.Text) And String.IsNullOrEmpty(txbFechaFin.Text) Then
                Dim buscarOrden = proxy.buscarOrdenPorId(viaje_revisado.id_orden)
                txbOrden.Text = buscarOrden.consecutivo
                txbAno.Text = buscarOrden.ano
            End If

            llenarGrid()
            txbOrden.Text = String.Empty
        End If



    End Sub




    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        llenarGrid()

    End Sub
    Private Sub llenarGrid()




        Dim ano = txbAno.Text
        Dim consecutivo = txbOrden.Text
        Dim inicio = String.Format("{0} 00:00", txbFechaInicio.Text)
        Dim fin = String.Format("{0} 23:59", txbFechaFin.Text)
        Dim idCliente = ddlEmpresa.SelectedValue



        SqlDataSource1.SelectParameters(0).DefaultValue = Nothing
        SqlDataSource1.SelectParameters(1).DefaultValue = Nothing
        SqlDataSource1.SelectParameters(2).DefaultValue = Nothing
        SqlDataSource1.SelectParameters(3).DefaultValue = Nothing
        SqlDataSource1.SelectParameters(4).DefaultValue = Nothing

        If Not String.IsNullOrEmpty(ano) And Not String.IsNullOrEmpty(consecutivo) Then
            SqlDataSource1.SelectParameters(0).DefaultValue = txbAno.Text
            SqlDataSource1.SelectParameters(1).DefaultValue = txbOrden.Text
        ElseIf Not String.IsNullOrEmpty(inicio) And Not String.IsNullOrEmpty(fin) Then
            SqlDataSource1.SelectParameters(2).DefaultValue = inicio
            SqlDataSource1.SelectParameters(3).DefaultValue = fin
            If idCliente <> 0 Then
                SqlDataSource1.SelectParameters(4).DefaultValue = idCliente
            End If
        Else
            SqlDataSource1.SelectParameters(2).DefaultValue = Now
            SqlDataSource1.SelectParameters(3).DefaultValue = Now

        End If
        txbOrden.Text = String.Empty
    End Sub

    Protected Sub CheckBox2_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkResponsable As CheckBox = CType(sender, CheckBox)
        Dim gvrFilaActual As GridViewRow = DirectCast(DirectCast(chkResponsable.Parent, DataControlFieldCell).Parent, GridViewRow)
        Dim _id_viaje = DirectCast(gvrFilaActual.Cells(0).FindControl("lblIdViaje"), Label).Text

        Dim viajeRemisionado = proxy.buscarViajePorId(_id_viaje)

        If Not viajeRemisionado Is Nothing Then

            If User.IsInRole("contabilidad") Or User.IsInRole("administrador") Then

                If viajeRemisionado.remision Then
                    viajeRemisionado.remision = False
                Else
                    viajeRemisionado.remision = True
                End If
                proxy.actualizarViaje(viajeRemisionado)
            Else
                lblMensaje.Text = "Usted no tiene privilegios suficientes."

            End If

            If String.IsNullOrEmpty(txbFechaInicio.Text) And String.IsNullOrEmpty(txbFechaFin.Text) Then
                Dim buscarOrden = proxy.buscarOrdenPorId(viajeRemisionado.id_orden)
                txbOrden.Text = buscarOrden.consecutivo
                txbAno.Text = buscarOrden.ano
            End If


            llenarGrid()
            txbOrden.Text = String.Empty
        End If
    End Sub

    Protected Sub btnDescargar_Click(sender As Object, e As EventArgs) Handles btnDescargar.Click
        ExportToExcel()
    End Sub
    Protected Sub ExportToExcel()
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=Ordenes " + txbFechaInicio.Text + "-" + txbFechaFin.Text + ".xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        Using sw As New StringWriter()
            Dim hw As New HtmlTextWriter(sw)

            'To Export all pages
            'GridView2.AllowPaging = False
            ' Me.BindGrid()

            GridView1.HeaderRow.BackColor = Drawing.Color.White
            For Each cell As TableCell In GridView1.HeaderRow.Cells
                cell.BackColor = GridView1.HeaderStyle.BackColor
            Next
            For Each row As GridViewRow In GridView1.Rows
                row.BackColor = Drawing.Color.White
                For Each cell As TableCell In row.Cells
                    If row.RowIndex Mod 2 = 0 Then
                        '-cell.BackColor = GridView1.AlternatingRowStyle.BackColor
                    Else
                        ' cell.BackColor = GridView1.RowStyle.BackColor
                    End If
                    cell.CssClass = "textmode"
                Next
            Next

            GridView1.RenderControl(hw)
            'style to format numbers to string
            Dim style As String = "<style> .textmode { } </style>"
            Response.Write(style)
            Response.Output.Write(sw.ToString())
            Response.Flush()
            Response.[End]()
        End Using
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim orden As String = txtOrden.Text
        Dim comentario As String = txtComentario.Text
        Dim ano As Integer = txtAnoObservacion.Text

        Dim query = (From consulta In db.viajes
                    Where consulta.Ordene.ano = ano And consulta.Ordene.consecutivo = orden
                    Select consulta).FirstOrDefault()

        If query Is Nothing Then
            Label2.Text = "La orden no existe en el año especificado o simplemente no existe"
        Else
            query.observaciones = comentario
            Try
                db.SubmitChanges()
                Label2.Text = "Observación guardada busque nuevamente la orden"
            Catch ex As Exception
                EnviarCorreo("sistemas@tse.com.mx", "Observaciones de orden con error", "Orden: " + query.Ordene.consecutivo + "año: " + txtAnoObservacion.Text)
                Label2.Text = ex.ToString()
            End Try
        End If





    End Sub
End Class