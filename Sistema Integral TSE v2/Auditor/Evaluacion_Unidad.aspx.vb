Public Class Evaluacion_Unidad
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year()
        End If
    End Sub

    Protected Sub txbBuscar_Click(sender As Object, e As EventArgs) Handles txbBuscar.Click
        Dim id_equipo = ddlUnidad.SelectedValue

        'sdsEvaluaciones.SelectParameters(0).DefaultValue = ddlMes.SelectedValue
        'sdsEvaluaciones.SelectParameters(1).DefaultValue = txbAno.Text
        'sdsEvaluaciones.SelectParameters(2).DefaultValue = id_equipo

        'GridView1.DataBind()
        Dim buscar_unidad = (From consulta In db.equipo_operacions
                          Where consulta.id_equipo = id_equipo
                          Select consulta).FirstOrDefault()

        If Not buscar_unidad Is Nothing Then
            lblUnidad.Text = String.Format("{0} {1} {2} {3}", buscar_unidad.tipo_equipo.equipo, buscar_unidad.economico, buscar_unidad.marca.marca, buscar_unidad.ano)
        End If

    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim sdsRecargasInternas As SqlDataSource = CType(e.Row.FindControl("sdsRecargasInternas"), SqlDataSource)
            Dim sdsRecargasExternas As SqlDataSource = CType(e.Row.FindControl("sdsRecargasExternas"), SqlDataSource)
            Dim sdsTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayectos"), SqlDataSource)
            Dim chkParcial As CheckBox = CType(e.Row.FindControl("chkParcial"), CheckBox)
            'Dim sdsInsite As SqlDataSource = CType(e.Row.FindControl("sdsInsite"), SqlDataSource)

            Dim idEquipoAsignado = e.Row.Cells(0).Text


            Dim rendimiento = proxy.buscarRendimientoPorIdEquipoAsignado(idEquipoAsignado)

            If Not rendimiento Is Nothing Then
                Dim buscarParcial = proxy.buscarParcialPorIdRendimiento(rendimiento.idRendimiento)

                If Not buscarParcial Is Nothing Then
                    chkParcial.Checked = True
                End If
            End If
            

                'sdsInsite.SelectParameters(0).DefaultValue = idOrden
                sdsTrayectos.SelectParameters(0).DefaultValue = idEquipoAsignado

                sdsRecargasInternas.SelectParameters(0).DefaultValue = idEquipoAsignado

                sdsRecargasExternas.SelectParameters(0).DefaultValue = idEquipoAsignado
        End If
    End Sub

    Protected Sub ddlUnidad_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.DataBound
        ddlUnidad.Items.Add(Crear_item("Todas...", Nothing))
    End Sub
End Class