Imports System.Data.SqlClient

Public Class Correctivos
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'txbAno.Text = Now.Year
        Else
            If Session("Tipo_Servicio") = 1 Then
                cargar_modal()
            End If
        End If
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        'Cambio agregado para evitar que guarden correctivos sin falla, unidad o algun otro dato 29 07 2015
        'If Not lblFalla.Text = "Sin Reporte" Then
        '----------------------------------------------------------------------------------------------
        'Se volvio a habilitar para que se pudieran guardar correctivos en cualquier momento 27 - ago -2015 y se colocaron otras validaciones
        'para asegurar que se campture la informacion necesario y no de errores
        Dim id_reporte = txbIdReporte.Text

        Dim idEquipo = 0
        'validaciones de datos
        If ddlCaja.SelectedValue <> 0 And ddlVehiculo.SelectedValue <> 0 Then
            lblMensaje.Text = "Debe seleccionar solo un tipo de unidad: Vehiculo o Caja"
            Return
        Else
            lblMensaje.Text = Nothing
        End If

        If String.IsNullOrWhiteSpace(txbCosto.Text) Then
            lblCosto.Text = "Debe indicar un costo el minimo es 0"
            Return
        Else
            lblCosto.Text = Nothing

        End If

        If String.IsNullOrWhiteSpace(txbOdometro.Text) Then
            lblOdometro.Text = "Debe indicar un odometro"
            Return
        Else
            lblOdometro.Text = Nothing

        End If

        If String.IsNullOrWhiteSpace(txbFecha.Text) Then
            lblFecha.Text = "Debe indicar la fecha"
            Return
        Else
            lblFecha.Text = Nothing

        End If

        If String.IsNullOrWhiteSpace(txbComentarios.Text) Then
            lblComentarios.Text = "Debe dar mas detalles de la reparación"
            Return
        Else
            lblComentarios.Text = Nothing

        End If
        '-------------------------------------------------------------------------------------------
        If ddlCaja.SelectedValue = 0 Then
            If ddlVehiculo.SelectedValue <> 0 Then
                idEquipo = ddlVehiculo.SelectedValue
            Else
                lblMensaje.Text = "Seleccione el equipo."
                Return
            End If
        Else
            idEquipo = ddlCaja.SelectedValue
        End If

        If Not String.IsNullOrEmpty(txbIdReporte.Text) Then
            Dim idReporte = txbIdReporte.Text

            Dim nuevaReparacion As New reparacione With {.odometro = txbOdometro.Text,
                                                     .fecha = txbFecha.Text,
                                                     .lugar = ddlLugar.SelectedValue,
                                                     .comentarios = txbComentarios.Text,
                                                      .tipo_reparacion = ddlReparacion.SelectedValue,
                                                    .costo = txbCosto.Text,
                                                    .idEquipo = idEquipo,
                                                    .idReporte = idReporte
                                                    }

            db.reparaciones.InsertOnSubmit(nuevaReparacion)
            db.SubmitChanges()

            Dim buscarReporte = (From consulta In db.reportes_fallas
                              Where consulta.ReporteId = Integer.Parse(idReporte)
                              Select consulta).FirstOrDefault()

            If Not buscarReporte Is Nothing Then
                buscarReporte.idEstatus = 6
            End If
            db.SubmitChanges()
        Else
            'Guardar correctivo sin reporte
            Dim nuevaReparacion As New reparacione With {.odometro = txbOdometro.Text,
                                                    .fecha = txbFecha.Text,
                                                    .lugar = ddlLugar.SelectedValue,
                                                    .comentarios = txbComentarios.Text,
                                                     .tipo_reparacion = ddlReparacion.SelectedValue,
                                                   .costo = txbCosto.Text,
                                                   .idEquipo = idEquipo
                                                   }
            db.reparaciones.InsertOnSubmit(nuevaReparacion)
            db.SubmitChanges()

        End If

        GridView2.DataBind()

        lblMensaje.Text = "Se guardó la información correctamente."
        'Else
        ' lblMensaje.Text = "Seleccione falla."
        ' End If
    End Sub

    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView2.SelectedIndexChanged

        ddlCaja.SelectedValue = 0
        ddlVehiculo.SelectedValue = 0
        Dim idReporte = GridView2.SelectedDataKey.Value.ToString()

        txbIdReporte.Text = idReporte
        lblMensaje.Text = String.Empty
        limpiar_formulario()

        Dim economico = (From consulta In db.reportes_fallas
                      Where consulta.ReporteId = idReporte
                      Select consulta).FirstOrDefault()

        If Not economico Is Nothing Then

            Dim buscarEquipo = (From consulta In db.equipo_operacions
                             Where consulta.id_equipo = economico.idEquipo
                             Select consulta).FirstOrDefault()

            If Not buscarEquipo Is Nothing Then
                If buscarEquipo.id_tipo_equipo < 106 Then
                    ddlVehiculo.SelectedValue = buscarEquipo.id_equipo
                Else
                    ddlCaja.SelectedValue = buscarEquipo.id_equipo
                End If
            End If

            Dim buscarFalla = (From consulta In db.reportes_fallas
                            Where consulta.ReporteId = idReporte
                            Select consulta).FirstOrDefault()

            If Not buscarFalla Is Nothing Then
                lblFalla.Text = buscarFalla.falla
            End If

        End If
    End Sub
    Public Sub limpiar_formulario()
        txbComentarios.Text = String.Empty
        txbFecha.Text = String.Empty
        txbOdometro.Text = String.Empty

    End Sub
    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        sdsReparacionesHechas.SelectParameters(0).DefaultValue = ddlEquipo.SelectedValue
        'sdsReparacionesHechas.SelectParameters(1).DefaultValue = txbAno.Text

        'If ddlEquipo.SelectedValue <> 0 Then
        '    sdsReparacionesHechas.SelectParameters(2).DefaultValue = ddlEquipo.SelectedValue
        'Else
        '    sdsReparacionesHechas.SelectParameters(2).DefaultValue = Nothing
        'End If

    End Sub

    Protected Sub ddlEquipo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEquipo.DataBound
        ddlEquipo.Items.Add(Crear_item("Todos...", 0))
    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkReparaciones.Click
        cargar_modal()

    End Sub
    Protected Sub cargar_modal()
        PlaceHolder1.Controls.Clear()
        Session("Correctivo") = True
        Dim nuevo_control As UserControl = LoadControl("~/controles_usuario/ctlPreventivos.ascx")
        PlaceHolder1.Controls.Add(nuevo_control)

    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        ddlReparacion.DataBind()


        Session("Tipo_Servicio") = 0
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim idReporte = e.Row.Cells(1).Text
            If idReporte = "" Then

            Else

                Dim buscarReporte = (From consulta In db.reportes_fallas
                              Where consulta.ReporteId = idReporte
                              Select consulta).FirstOrDefault()
                If Not buscarReporte Is Nothing Then
                    Dim lblFecha As Label = CType(e.Row.FindControl("lblFecha"), Label)
                    Dim lblChofer As Label = CType(e.Row.FindControl("lblChofer"), Label)
                    Dim lblTipoEquipo As Label = CType(e.Row.FindControl("lblTipoEquipo"), Label)
                    Dim lblEconomico As Label = CType(e.Row.FindControl("lblEconomico"), Label)

                    Dim idChofer = buscarReporte.idChofer
                    Dim idEquipo = buscarReporte.idEquipo
                    Dim idOrden = buscarReporte.idOrden
                    Dim buscarEquipo = (From consulta In db.equipo_operacions
                                                    Where consulta.id_equipo = idEquipo
                                                    Select consulta).FirstOrDefault()

                    If Not buscarEquipo Is Nothing Then
                        lblEconomico.Text = buscarEquipo.economico
                        lblTipoEquipo.Text = buscarEquipo.tipo_equipo.equipo
                    End If

                    Dim buscarFecha = (From consulta In db.fechas_ordenes
                                    Where consulta.id_orden = idOrden And
                                    consulta.fecha.tipo_fecha = 1
                                    Select consulta).FirstOrDefault()

                    If Not buscarFecha Is Nothing Then
                        lblFecha.Text = buscarFecha.fecha.fecha
                    Else
                        Dim buscarFechaReporte = (From consulta In db.reportes_fallas
                                    Where consulta.ReporteId = idReporte
                                    Select consulta).FirstOrDefault()
                        If Not buscarFechaReporte Is Nothing Then
                            lblFecha.Text = buscarFechaReporte.fecha
                        End If
                    End If



                    Dim buscarChofer = (From consulta In db.empleados
                                     Where consulta.id_empleado = idChofer
                                     Select consulta).FirstOrDefault()

                    If Not buscarChofer Is Nothing Then
                        lblChofer.Text = String.Format("{0} {1}", buscarChofer.persona.primer_nombre, buscarChofer.persona.apellido_paterno)
                    End If
                End If






            End If
        End If
    End Sub

    Protected Sub ddlVehiculo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlVehiculo.DataBound
        ddlVehiculo.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub ddlCaja_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCaja.DataBound
        ddlCaja.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblEquipo As Label = CType(e.Row.FindControl("lblEquipo"), Label)
            Dim lblFalla As Label = CType(e.Row.FindControl("lblFalla"), Label)
            Dim lblTipoEquipo As Label = CType(e.Row.FindControl("lblTipoEquipo"), Label)
            Dim lblTipoRep As Label = CType(e.Row.FindControl("lblTipoReparacion"), Label)
            Dim idReparacion = e.Row.Cells(1).Text

            Dim buscarReporte = (From consulta In db.reparaciones
                              Where consulta.idReparacion = idReparacion
                              Select consulta).FirstOrDefault()
            'se agrego que se pudiera ver el detalle del tipo de reparacion en lugar del id  15 07 2015
            Dim buscarTipoRep = (From consulta In db.reparaciones, consulta2 In db.Tipo_reparacions
                                          Where consulta.idReparacion = idReparacion And consulta.tipo_reparacion = consulta2.id
                                          Select consulta2.reparacion).FirstOrDefault()
            '-----------------------------------------------------------------------------------------
            If Not buscarReporte Is Nothing Then
                Dim idEquipo = buscarReporte.idEquipo

                Dim buscarEquipo = (From consulta In db.equipo_operacions
                                 Where consulta.id_equipo = idEquipo
                                 Select consulta).FirstOrDefault()

                If Not buscarEquipo Is Nothing Then
                    lblEquipo.Text = buscarEquipo.economico
                    lblTipoEquipo.Text = buscarEquipo.tipo_equipo.equipo
                End If



                If Not buscarReporte.idReporte Is Nothing Then
                    lblFalla.Text = buscarReporte.reportes_falla.falla
                    'template field para mostrar el nombre d ela reparacion 15 07 2015 
                    lblTipoRep.Text = buscarTipoRep
                End If


            End If

        End If
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        Response.Redirect("~/Mantenimiento/correctivos.aspx")
    End Sub

    Protected Sub GridView2_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles GridView2.RowDeleting
        Dim id As String = GridView2.DataKeys(e.RowIndex).Value.ToString()
        borrar(id)
    End Sub
    Sub borrar(id As String)
        Dim sc As New SqlConnection("Data Source=rtbygfdtxb.database.windows.net;Initial Catalog=tse_erp;User ID=omarifr;Password=Ifrramo2.")
        sc.Open()
        'Dim row As GridViewRow = GridView2.Rows(e.RowIndex)
        'corregir
        'Dim val As Label = DirectCast(row.FindControl("ReporteId"), Label)
        'Dim id2 As String = val.Text
        'Int32 valor = Convert.ToInt32(val);
        Dim cmd As New SqlCommand("Delete From [reportes_fallas] WHERE [ReporteId]=@id", sc)
        cmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id
        cmd.ExecuteNonQuery()
        'SqlCommand cmd2 = new SqlCommand("Delete from lg.Ubicacion where id_kardex=(select max(id_kardex) from lg.Kardex)");

        sc.Close()

    End Sub
End Class