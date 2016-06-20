Imports System.Data.SqlClient

Public Class Presentacion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtQ1.Focus()

    End Sub

    Protected Sub btnCargar_Click(sender As Object, e As EventArgs) Handles btnCargar.Click
        If FuPresentacion.HasFile Then
            Dim fileName As String
            Dim fileOk As Boolean = False
            Dim extension As String = System.IO.Path.GetExtension(FuPresentacion.FileName).ToLower
            Dim ext As String() = {".pdf"}
            For i As Integer = 0 To ext.Length - 1
                If extension = ext(i) Then
                    fileOk = True
                End If
            Next
            If fileOk = True Then
                fileName = "presentacion.pdf"
                FuPresentacion.SaveAs(Server.MapPath("~/Cursos/") + fileName)
                Response.Write("<script>alert('Archivo cargado correctamente.')</script>")

            Else
                Response.Write("<script>alert('NO HAZ SELECCIONADO NINGUN ARCHIVO PDF.')</script>")

            End If
        Else
            Response.Write("<script>alert('No haz seleccionado ningun archivo')</script>")
        End If
    End Sub
    Public Sub limpiar()
        txtQ1.Text = ""
        txtCorrecta1.Text = ""
        txtOp1.Text = ""
        txtOp2.Text = ""
        lblNumero.Text = ""
        btnGuardar.Text = "Guardar"
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        If btnGuardar.Text = "Actualizar" Then
            SdsPreguntas.Update()
        Else
            If btnGuardar.Text = "Guardar" Then
                SdsPreguntas.Insert()
            End If
        End If

        Response.Write("<script>alert('Registro guardado correctamente')</script>")
        limpiar()
        txtQ1.Focus()
    End Sub


    Protected Sub GridView2_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView2.RowCommand

        If e.CommandName = "Editar" Then
            btnGuardar.Text = "Actualizar"
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            lblNumero.Text = GridView2.Rows(index).Cells(1).Text
            txtQ1.Text = GridView2.Rows(index).Cells(2).Text
            txtCorrecta1.Text = GridView2.Rows(index).Cells(3).Text
            txtOp1.Text = GridView2.Rows(index).Cells(4).Text
            txtOp2.Text = GridView2.Rows(index).Cells(5).Text
        Else
            Response.Write("<script>alert('Error al cargar los datos')</script>")

        End If


    End Sub


    Protected Sub GridView2_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles GridView2.RowUpdating
        Dim row As GridViewRow = GridView2.Rows(e.RowIndex)
        Dim respuesta As TextBox = DirectCast(row.FindControl("Respuesta"), TextBox)
        Dim OPc1 As TextBox = DirectCast(row.FindControl("Op1"), TextBox)
        Dim OPc2 As TextBox = DirectCast(row.FindControl("Op2"), TextBox)
        Dim id As Integer = Int32.Parse(GridView2.DataKeys(e.RowIndex).Value.ToString())
        Dim qes, resp, op1, op2 As String
        qes =
        resp = respuesta.Text
        op1 = OPc1.Text
        op2 = OPc2.Text
        updateTabla(id, resp, op1, op2)

    End Sub

    Sub updateTabla(id As Integer, resp As String, op1 As String, op2 As String)
        Dim constr2 As String = "Data Source=rtbygfdtxb.database.windows.net;Initial Catalog=ERP;User ID=omarifr;Password=Ifrramo2."

        Dim query2 As String = "Update PreguntasInduccion set Pregunta=@pregunta, respuesta=@Respuesta, op1=@op1, op2=@op2 where id=@id"
        Dim con2 As New SqlConnection(constr2)
        Dim com2 As New SqlCommand(query2, con2)
        com2.Parameters.Add("@id", SqlDbType.Int).Value = id
        com2.Parameters.Add("@Respuesta", SqlDbType.VarChar).Value = resp
        com2.Parameters.Add("@op1", SqlDbType.VarChar).Value = op1
        com2.Parameters.Add("@op2", SqlDbType.VarChar).Value = op2

        con2.Open()
        com2.ExecuteNonQuery()
        con2.Close()
    End Sub

    Protected Sub GridView2_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles GridView2.RowCancelingEdit
        e.Cancel = True
        GridView2.EditIndex = -1
    End Sub

    Protected Sub GridView2_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles GridView2.RowEditing
        GridView2.EditIndex = e.NewEditIndex
    End Sub
End Class