Public Class listasDistribucion
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then


        End If
        If Session("listaActiva") = 1 Then
            cargarControl()
        End If
        If Session("asignarContactos") = 1 Then
            cargarAsignacion()
        End If
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        cargarControl()

    End Sub
    Private Sub cargarControl()
        Session("listaActiva") = 1
        Try
            ModalPopupExtender1.Show()
            Dim nuevoControl As UserControl = LoadControl("~/Controles_Usuario/ctlNuevaLista.ascx")

            PlaceHolder1.Controls.Add(nuevoControl)
        Catch ex As Exception
            lblMensaje.Text = String.Format("Error: {0}", ex.Message)
        End Try
    End Sub
    Private Sub cargarAsignacion()
        Session("asignarContactos") = 1
        Try
            ModalPopupExtender1.Show()
            Dim nuevoControl As UserControl = LoadControl("~/Controles_Usuario/ctlCuentasSeguimiento.ascx")

            PlaceHolder1.Controls.Add(nuevoControl)
        Catch ex As Exception
            lblMensaje.Text = String.Format("Error: {0}", ex.Message)
        End Try
    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click

        Session("listaActiva") = 0
        Session("asignarContactos") = 0
        ddlLista.DataBind()

        ModalPopupExtender1.Hide()
    End Sub

    Protected Sub ddlLista_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlLista.DataBound
        ddlLista.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub

    Protected Sub btnEliminar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEliminar.Click
        If Not String.IsNullOrEmpty(txbIdLista.Text) Then
            Dim idLista = txbIdLista.Text

            Dim buscarLista = (From consulta In db.listaDistribucions
                              Where consulta.idLista = idLista
                              Select consulta).FirstOrDefault()
            If Not buscarLista Is Nothing Then
                buscarLista.idStatus = 6
                db.SubmitChanges()
                GridView2.DataBind()
            Else
                lblMensaje.Text = "No se encotró la lista seleccionada."
            End If
        End If
    End Sub

    Protected Sub ddlLista_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlLista.SelectedIndexChanged
        txbIdLista.Text = ddlLista.SelectedValue
    End Sub

    Protected Sub lnkAsignarASeguimiento_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkAsignarASeguimiento.Click
        Session("asignarContactos") = 1
        cargarAsignacion()

    End Sub
End Class