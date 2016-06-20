Public Partial Class Viaje_de_Vuelta
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.Year.ToString()
        End If

    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged

        Dim row As GridViewRow = GridView1.SelectedRow
        Dim id_orden As String = row.Cells(1).Text

        Response.Redirect("~/Sup.Trafico/invisibles/viaje_con_carga.aspx?id_orden=" + id_orden)

    End Sub

    
    

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim viaje = From consulta In db.viajes
                  Where consulta.Ordene.ano = txbAno.Text And
                  consulta.Ordene.consecutivo = txbConsecutivo.Text And
                  consulta.id_status <> 5 And
                  consulta.id_status <> 3
                  Select orden = consulta.Ordene.ano.ToString() + "-" + consulta.Ordene.consecutivo.ToString() + "-" + consulta.num_viaje.ToString(),
                  consulta.precio.empresa.nombre,
                  consulta.precio.llave_ruta.ruta,
                  consulta.Ordene.id_orden


        GridView1.DataSource = viaje
        GridView1.DataBind()


        

    End Sub
End Class