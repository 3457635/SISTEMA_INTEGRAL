Public Class ctlCajas
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEquipo.SelectedIndexChanged
        Dim db As New DataClasses1DataContext()
        limpiar_formulario()
        lblMensaje.Text = ""

        Dim caja = (From consulta In db.equipo_operacions
                   Where consulta.id_equipo = ddlEquipo.SelectedValue
                   Select consulta).First()
        If Not caja.ano Is Nothing Then
            txbAno.Text = caja.ano.ToString()
        End If
        If Not caja.economico Is Nothing Then
            txbEconomico.Text = caja.economico.ToString()
        End If
        If Not caja.id_marca Is Nothing Then
            ddlmarca.SelectedValue = caja.id_marca.ToString()
        End If
        If Not caja.serie Is Nothing Then
            txbSerie.Text = caja.serie.ToString()
        End If
        If Not caja.placa Is Nothing Then
            txbPlaca.Text = caja.placa.ToString()
        End If

        Dim datos = (From consulta In db.datos_cajas
                    Where consulta.id_equipo = caja.id_equipo
                    Select consulta).FirstOrDefault()
        If Not datos.pies Is Nothing Then
            txbPies.Text = datos.pies.ToString()
        End If
        If Not datos.id_tipo_uso Is Nothing Then
            ddlUso.SelectedValue = datos.id_tipo_uso.ToString()
        End If
        If Not datos.id_cruce Is Nothing Then
            If datos.id_cruce Then
                CheckBox1.Checked = True
            End If
        End If

        txbIdEquipo.Text = caja.id_equipo.ToString()

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim db As New DataClasses1DataContext()
        If txbIdEquipo.Text <> "" Then
            Dim caja = (From consulta In db.Cajas
                       Where consulta.CajaId = txbIdEquipo.Text
                       Select consulta).First()

            caja.ano = txbAno.Text
            caja.economico = txbEconomico.Text
            caja.marcaId = ddlmarca.Text
            caja.placa = txbPlaca.Text
            caja.serie = txbSerie.Text


            Dim datos = (From consulta In db.datos_cajas
                        Where consulta.id_equipo = txbIdEquipo.Text
                        Select consulta).FirstOrDefault()

            datos.id_cruce = CheckBox1.Checked
            datos.id_tipo_uso = ddlUso.SelectedValue
            datos.pies = txbPies.Text

            db.SubmitChanges()
            ddlEquipo.DataBind()
            lblMensaje.Text = "Se actualizó la información de la caja " + caja.economico.ToString()
            limpiar_formulario()
        Else

            Dim caja As New Caja With {.ano = txbAno.Text,
                                                   .economico = txbEconomico.Text,
                                                   .marcaId = ddlmarca.SelectedValue,
                                                   .placa = txbPlaca.Text,
                                                   .serie = txbSerie.Text,
                                                   .estatusId = 5
                                                   }
            Dim datos As New datos_caja With {.id_cruce = CheckBox1.Checked,
                                              .id_tipo_uso = ddlUso.SelectedValue,
                                              .pies = txbPies.Text,
                                              .Caja = caja}

            db.Cajas.InsertOnSubmit(caja)
            db.SubmitChanges()
            lblMensaje.Text = "Se guardó la información de la caja " + caja.economico.ToString()
            ddlEquipo.DataBind()
            limpiar_formulario()
        End If
    End Sub

    Protected Sub btnEliminar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEliminar.Click
        Dim db As New DataClasses1DataContext()
        If txbIdEquipo.Text <> "" Then
            Dim caja = (From consulta In db.equipo_operacions
                          Where consulta.id_equipo = txbIdEquipo.Text
                          Select consulta).First()
            caja.id_status = 6
            db.SubmitChanges()
            ddlEquipo.DataBind()
            lblMensaje.Text = "Se eliminó la información de la caja " + caja.economico.ToString()
            limpiar_formulario()
        Else
            lblMensaje.Text = "Seleccione la caja a eliminar."
        End If
    End Sub
    Protected Sub limpiar_formulario()
        txbAno.Text = ""
        txbEconomico.Text = ""
        txbIdEquipo.Text = ""
        txbPies.Text = ""
        txbPlaca.Text = ""
        txbSerie.Text = ""
        CheckBox1.Checked = False
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        limpiar_formulario()
        lblMensaje.Text = ""
    End Sub
End Class