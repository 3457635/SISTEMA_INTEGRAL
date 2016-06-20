Imports System.Data.Linq
Imports System.Data.Linq.Mapping
Public Class ctlUnidad
    Inherits System.Web.UI.UserControl
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim db As New DataClasses1DataContext()
        Dim placa = StrConv(txbPlaca.Text, VbStrConv.Uppercase)
        Dim serie = StrConv(txbSerie.Text, VbStrConv.Uppercase)


        If txbIdEquipo.Text = "" Then

            Dim equipo As New wcfRef1.equipo_operacion
            equipo.placa = placa
            equipo.economico = txbEconomico.Text
            equipo.id_status = 5
            equipo.id_tipo_equipo = ddlVehiculo.SelectedValue
            equipo.ano = txbAno.Text
            equipo.serie = serie
            equipo.id_marca = ddlMarca.SelectedValue
            equipo.idBase = ddlBase.SelectedValue
            equipo.idUso = ddlTipoUso.SelectedValue
            proxy.crearEquipoOperacion(equipo)

        Else
            Dim actualizar_equipo = proxy.buscarEquipoPorId(txbIdEquipo.Text)
            If Not actualizar_equipo Is Nothing Then
                actualizar_equipo.ano = txbAno.Text
                actualizar_equipo.economico = txbEconomico.Text
                actualizar_equipo.id_marca = ddlMarca.Text
                actualizar_equipo.id_tipo_equipo = ddlVehiculo.SelectedValue
                actualizar_equipo.placa = placa
                actualizar_equipo.serie = serie
                actualizar_equipo.idUso = ddlTipoUso.SelectedValue
                actualizar_equipo.idBase = ddlBase.SelectedValue

                proxy.actualizarEquipoOperacion(actualizar_equipo)

            End If

        End If
        db.SubmitChanges()
        lblMensaje.Text = "Se guardo la información de la unidad " + txbEconomico.Text
        limpiar_formulario()
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        lblMensaje.Text = ""
        txbIdEquipo.Text = DropDownList1.SelectedValue

        Dim equipo = proxy.buscarEquipoPorId(DropDownList1.SelectedValue)

        If Not equipo Is Nothing Then
            txbAno.Text = equipo.ano
            txbEconomico.Text = equipo.economico
            txbPlaca.Text = equipo.placa
            ddlMarca.SelectedValue = equipo.id_marca
            ddlTipoUso.SelectedValue = equipo.idUso
            ddlVehiculo.SelectedValue = equipo.id_tipo_equipo
            ddlBase.SelectedValue = equipo.idBase
            txbSerie.Text = equipo.serie
        End If

    End Sub

    Protected Sub limpiar_formulario()
        txbAno.Text = ""
        txbEconomico.Text = ""
        txbIdEquipo.Text = ""
        txbPlaca.Text = ""
        txbSerie.Text = ""

        ddlMarca.DataBind()
        ddlVehiculo.DataBind()
        DropDownList1.DataBind()
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        lblMensaje.Text = ""
        limpiar_formulario()
    End Sub

    Protected Sub btnBaja_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBaja.Click
        Dim db As New DataClasses1DataContext()
        Dim equipo_baja = (From query In db.equipo_operacions
                          Where query.id_equipo = txbIdEquipo.Text
                          Select query).Single()

        equipo_baja.id_status = 6
        db.SubmitChanges()
        lblMensaje.Text = "El equipo " + txbEconomico.Text + " se dio de baja."
        limpiar_formulario()
    End Sub

End Class