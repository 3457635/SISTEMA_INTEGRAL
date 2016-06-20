Imports System.Data.SqlClient

Public Class incidentes
    Inherits System.Web.UI.Page
    Dim db As New DataClasses2DataContext()
    Dim db2 As New aspNetMemberShipDataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblFechaSer.Text = Now.ToString()
        Dim conexion As New ConexionSQL()

        Dim tabla As New DataTable()
        conexion.getDataQuery("SELECT (SELECT	COUNT(cuadrante_actual) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where idestatus =1 and cuadrante_actual = 1) as C1," & _
                            "(SELECT	COUNT(cuadrante_actual) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where idestatus =1 and cuadrante_actual = 2) as C2," & _
                            "(SELECT	COUNT(cuadrante_actual) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where idestatus =1 and cuadrante_actual = 3) as C3," & _
                            "(SELECT	COUNT(cuadrante_actual) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where idestatus =1 and cuadrante_actual = 4) as C4", tabla)
        conexion.Cerrar()
        cd1.Text = tabla.Rows(0)("C1")
        cd2.Text = tabla.Rows(0)("C2")
        cd3.Text = tabla.Rows(0)("C3")
        cd4.Text = tabla.Rows(0)("C4")
        contarTodos()
        Recalcular()
    End Sub

    Sub contarTodos()
        Dim RoleId As String = "Todos"
        Dim constr As String = "Data Source=rtbygfdtxb.database.windows.net;Initial Catalog=tse_erp;User ID=omarifr;Password=Ifrramo2."
        Dim con As New SqlConnection(constr)
        Dim sqlcomm As SqlCommand
        con.Open()
        sqlcomm = New SqlCommand()
        sqlcomm.Connection = con
        sqlcomm.CommandType = CommandType.StoredProcedure
        sqlcomm.CommandText = "[Cuadrante_Por_Roles]"
        sqlcomm.Parameters.Add(New SqlParameter("@cRoleId", SqlDbType.VarChar)).Value = RoleId
        sqlcomm.ExecuteNonQuery()
        sqlcomm.Dispose()
        con.Close()

    End Sub
    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim tiempo As Double = (Convert.ToDateTime(txbFechaPropuesta.Text) - DateTime.Now().AddHours(-7)).Days * 8
        Dim urg As Double

        If tiempo = 0 Then
            urg = 1
        Else
            urg = Convert.ToDouble(txtTiempoEstimado.Text) / tiempo
        End If

        Dim nuevoIncidente As New incidente With {.incidente = txbIncidente.Text,
                                                  .fechaIncidente = txbFechaIncidente.Text,
                                                  .fechaPropuesta = txbFechaPropuesta.Text,
                                                  .comentarios = txbComentarios.Text,
                                                  .RoleId = New Guid(ddlDepartamento.SelectedValue),
                                                  .idEstatus = 1,
                                                  .estimado = txtTiempoEstimado.Text,
                                                  .importancia = ddlImportancia.SelectedValue,
                                                  .urgencia = calcularCuadrante(urg),
                                                  .cuadrante = Convert.ToInt32((.urgencia + .importancia) / 2),
        .id_tipo_incidente = comboTipoIncidente.SelectedValue
                                                  }
        db.incidentes.InsertOnSubmit(nuevoIncidente)
        db.SubmitChanges()
        txbComentarios.Text = String.Empty
        txbFechaIncidente.Text = String.Empty
        txbFechaPropuesta.Text = String.Empty
        txbIncidente.Text = String.Empty
        lblMensaje.Text = String.Format("Se creó el incidente {0} exitosamente.", nuevoIncidente.id)
        grdIncidentes.DataBind()
    End Sub
    Public Function calcularCuadrante(ByVal urgencia As Double)
        Dim a As Integer
        If urgencia < 0 Then
            a = 1.0
        ElseIf urgencia < 0.25 Then
            a = 4.0
        ElseIf urgencia < 0.5 Then
            a = 3.0
        ElseIf urgencia < 0.75 Then
            a = 2.0
        Else
            a = 1.0
        End If
        Return a
    End Function
    Sub Recalcular()
        Dim constr As String = "Data Source=rtbygfdtxb.database.windows.net;Initial Catalog=tse_erp;User ID=omarifr;Password=Ifrramo2."
        Dim con As New SqlConnection(constr)
        Dim sqlcomm As SqlCommand
        con.Open()
        sqlcomm = New SqlCommand()
        sqlcomm.Connection = con
        'Se indica que sera un SP 
        sqlcomm.CommandType = CommandType.StoredProcedure
        'Nombre del SP
        sqlcomm.CommandText = "[Calcula_Cuadrante_Actual]"
        'Parametros del SP
        'sqlcomm.Parameters.Add(new SqlParameter("@alto", SqlDbType.Decimal)).Value = alto;
        sqlcomm.ExecuteNonQuery()
        sqlcomm.Dispose()
        con.Close()
    End Sub
    Sub filtrarTabla()
        Dim C1, C2, C3, C4 As String
        For Each dgItem As DataGridItem In dgCuadrantes.Items
            C1 = dgItem.Cells(0).Text
            C2 = dgItem.Cells(1).Text
            C3 = dgItem.Cells(2).Text
            C4 = dgItem.Cells(3).Text
            cd1.Text = C1
            cd2.Text = C2
            cd3.Text = C3
            cd4.Text = C4
        Next
        btnBuscar_Click(1, Nothing)
    End Sub
    Protected Sub btnBuscar_Click(sender As Object, e As ImageClickEventArgs) Handles btnBuscar.Click
        Dim idEstatus = ddlEstatus.SelectedValue
        Dim RoleId As String = ddlRoles.SelectedValue
        Dim cuadrante = ddlCuadraCon.SelectedValue
        'completar
        Dim idFecha As Integer = Nothing
        If rbFInci.Checked = True Then
            idFecha = 1
        End If
        If rbFPro.Checked = True Then
            idFecha = 2
        End If
        If rbFResp.Checked = True Then
            idFecha = 3
        End If
        If rbSFecha.Checked = True Then
            idFecha = 0
        End If
        If rbFInci.Checked = False And rbFPro.Checked = False And rbFResp.Checked = False Then
            idFecha = 0
        End If

        If ddlCuadraCon.SelectedValue = "Todos" Then
            cuadrante = Nothing
        End If
        If idEstatus = 0 Then
            Recalcular()
            sdsIncidentes.SelectParameters.Item("nCuadrante_Actual").DefaultValue = cuadrante
            sdsIncidentes.SelectParameters.Item("tipoFecha").DefaultValue = idFecha
            sdsTabla.SelectParameters.Item("cRoleId").DefaultValue = RoleId
            sdsIncidentes.SelectParameters.Item("nIdEstatus").DefaultValue = Nothing
        Else
            Recalcular()
            sdsIncidentes.SelectParameters.Item("nCuadrante_Actual").DefaultValue = cuadrante
            sdsIncidentes.SelectParameters.Item("nIdEstatus").DefaultValue = idEstatus
            sdsIncidentes.SelectParameters.Item("tipoFecha").DefaultValue = idFecha
            sdsTabla.SelectParameters.Item("cRoleId").DefaultValue = RoleId
        End If
        If RoleId = "00000000-0000-0000-0000-000000000000" Then
            Recalcular()
            sdsIncidentes.SelectParameters.Item("nCuadrante_Actual").DefaultValue = cuadrante
            sdsIncidentes.SelectParameters.Item("cRoleId").DefaultValue = Nothing
            sdsIncidentes.SelectParameters.Item("tipoFecha").DefaultValue = idFecha
        Else
            Recalcular()
            sdsIncidentes.SelectParameters.Item("cRoleId").DefaultValue = RoleId.ToString()
            sdsIncidentes.SelectParameters.Item("nCuadrante_Actual").DefaultValue = cuadrante
            sdsIncidentes.SelectParameters.Item("tipoFecha").DefaultValue = idFecha
            sdsTabla.SelectParameters.Item("cRoleId").DefaultValue = RoleId
        End If
        Dim C1, C2, C3, C4 As String
        UpdatePanel1.DataBind()
        sdsTabla.SelectParameters.Item("cRoleId").DefaultValue = RoleId
        dgCuadrantes.DataBind()
        For Each dgItem As DataGridItem In dgCuadrantes.Items
            C1 = dgItem.Cells(0).Text
            C2 = dgItem.Cells(1).Text
            C3 = dgItem.Cells(2).Text
            C4 = dgItem.Cells(3).Text
            cd1.Text = C1
            cd2.Text = C2
            cd3.Text = C3
            cd4.Text = C4
        Next
        If ddlEstatus.Text = "0" And ddlCuadraCon.Text = "0" And ddlDepartamento.Text = "00000000-0000-0000-0000-000000000000" Then
            Response.Redirect("~/Reportes_Abiertos/incidentes.aspx")
        End If
    End Sub

    Protected Sub grdIncidentes_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles grdIncidentes.RowUpdating
    End Sub
End Class