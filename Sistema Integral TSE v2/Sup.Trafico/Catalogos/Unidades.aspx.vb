Public Class Unidades
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

        End If
    End Sub

    
    Protected Sub ddlTipoEquipo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTipoEquipo.DataBound
        ddlTipoEquipo.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub ddlMarca_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlMarca.DataBound
        ddlMarca.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub ddlEstatus_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEstatus.DataBound
        ddlEstatus.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        Dim idTipoEquipo = Nothing
        Dim idMarca = Nothing
        Dim Estado = Nothing
        Dim economico = Nothing
        Dim ano = Nothing

        If ddlTipoEquipo.SelectedValue <> 0 Then
            idTipoEquipo = ddlTipoEquipo.SelectedValue
        End If

        If ddlMarca.SelectedValue <> 0 Then
            idMarca = ddlMarca.SelectedValue
        End If

        If ddlEstatus.SelectedValue <> 0 Then
            Estado = ddlEstatus.SelectedValue
        End If

        If Not String.IsNullOrEmpty(txbAno.Text) Then
            ano = txbAno.Text
        End If

        If Not String.IsNullOrEmpty(txbEconomico.Text) Then
            economico = txbEconomico.Text
        End If


        sdsUnidadesModificar.SelectParameters(0).DefaultValue = Estado
        sdsUnidadesModificar.SelectParameters(1).DefaultValue = idTipoEquipo
        sdsUnidadesModificar.SelectParameters(2).DefaultValue = ano
        sdsUnidadesModificar.SelectParameters(3).DefaultValue = idMarca
        sdsUnidadesModificar.SelectParameters(4).DefaultValue = economico

        ddlEstatus.SelectedValue = 0
        ddlMarca.SelectedValue = 0
        ddlTipoEquipo.SelectedValue = 0

        txbAno.Text = String.Empty
        txbEconomico.Text = String.Empty

    End Sub


End Class