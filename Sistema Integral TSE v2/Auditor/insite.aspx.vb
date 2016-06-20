Public Class insite
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click


        'Dim idOrden = ddlOrden.SelectedValue

        'Dim buscarInsite = (From consulta In db.insites
        '                    Where (consulta.idOrden = idOrden)
        '                    Select consulta).FirstOrDefault()

        'If buscarInsite Is Nothing Then
        '    Dim nuevoInsite As New insite With {.idOrden = idOrden,
        '                                        .rendimiento = txbRendimiento.Text}

        '    db.insites.InsertOnSubmit(nuevoInsite)

        '    lblMensaje.Text = "Se guardó el rendimiento."
        'Else
        '    buscarInsite.rendimiento = txbRendimiento.Text
        '    lblMensaje.Text = "Se aztualizó el rendimiento."
        'End If

        'db.SubmitChanges()
    End Sub

    Protected Sub ddlOrden_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlOrden.DataBound
        ddlOrden.Items.Add(Crear_item("Seleccionar..", 0))

    End Sub

    Protected Sub ddlOrden_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlOrden.SelectedIndexChanged
        'Dim buscarInsite = (From consulta In db.insites
        '                 Where consulta.idOrden = ddlOrden.SelectedValue
        '                 Select consulta).FirstOrDefault()

        'If Not buscarInsite Is Nothing Then
        '    txbRendimiento.Text = buscarInsite.rendimiento
        'Else
        '    txbRendimiento.Text = String.Empty
        'End If

    End Sub

   

End Class