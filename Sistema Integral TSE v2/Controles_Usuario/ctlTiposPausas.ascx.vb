Public Class ctlTiposPausas
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            cargar_grid()
        Else
            Session("arrivos") = 2
        End If
    End Sub
    Protected Sub cargar_grid()
        ddlPausa.Items.Add(New ListItem("Seleccionar...", 0))
        ddlPausa.SelectedValue = 0
    End Sub
    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If Not String.IsNullOrEmpty(txbPausa.Text) Then
            If String.IsNullOrEmpty(txbIdPausa.Text) Then
                Dim nueva_pausa As New tipos_pausa With {.pausa = txbPausa.Text, .id_status = 5}
                db.tipos_pausas.InsertOnSubmit(nueva_pausa)
            Else
                Dim buscar_pausa = (From consulta In db.tipos_pausas
                                 Where consulta.id_tipo_pausa = txbIdPausa.Text
                                 Select consulta).FirstOrDefault()

                If Not buscar_pausa Is Nothing Then
                    buscar_pausa.pausa = txbPausa.Text
                End If
            End If
            db.SubmitChanges()
            lblMensaje.Text = "Se guardó la pausa."
            ddlPausa.DataBind()
        Else
            lblMensaje.Text = "Ingrese la descripción de la pausa."
        End If
    End Sub

    Protected Sub btnBorrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBorrar.Click
        Dim buscar_pausa = (From consulta In db.tipos_pausas
                                Where consulta.id_tipo_pausa = txbIdPausa.Text
                                Select consulta).FirstOrDefault()

        If Not buscar_pausa Is Nothing Then
            buscar_pausa.id_status = 6
            db.SubmitChanges()
            ddlPausa.DataBind()
        End If
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        cargar_grid()
        txbIdPausa.Text = String.Empty
        txbPausa.Text = String.Empty

    End Sub
End Class