Public Class Examen
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtClave.Focus()

    End Sub
    Sub correcto()
        txtClave.Visible = False
        btnIniciar.Visible = False
        lblClave.Visible = False
        lblInst.Text = "Lea bien las preguntas antes de responder, cualquier duda favor de comentarlo con el personal."
        Datos()
    End Sub
    Protected Sub btnIniciar_Click(sender As Object, e As EventArgs) Handles btnIniciar.Click
        If txtClave.Text = "induccion2016." Then
            pnlExam.Visible = True
            txtClave.Text = ""
            correcto()

        Else
            Response.Write("<script>alert('LA CONTRASEÑA ES INCORRECTA')</script>")
            txtClave.Focus()
            txtClave.Text = ""
            pnlExam.Visible = False
        End If
    End Sub
    Public Sub Datos()
        'Obtener datos del grid para llenar las preguntas
        q1.Text = gvPreguntas.Rows(0).Cells(1).Text
        'c
        rb2.Text = gvPreguntas.Rows(0).Cells(2).Text
        rb1.Text = gvPreguntas.Rows(0).Cells(3).Text
        rb3.Text = gvPreguntas.Rows(0).Cells(4).Text

        q2.Text = gvPreguntas.Rows(1).Cells(1).Text
        'correcta
        rb4.Text = gvPreguntas.Rows(1).Cells(2).Text
        rb5.Text = gvPreguntas.Rows(1).Cells(3).Text
        rb6.Text = gvPreguntas.Rows(1).Cells(4).Text

        q3.Text = gvPreguntas.Rows(2).Cells(1).Text
        'correcta
        rb9.Text = gvPreguntas.Rows(2).Cells(2).Text
        rb7.Text = gvPreguntas.Rows(2).Cells(3).Text
        rb8.Text = gvPreguntas.Rows(2).Cells(4).Text

        q4.Text = gvPreguntas.Rows(3).Cells(1).Text
        'correcta
        rb12.Text = gvPreguntas.Rows(3).Cells(2).Text
        rb11.Text = gvPreguntas.Rows(3).Cells(3).Text
        rb10.Text = gvPreguntas.Rows(3).Cells(4).Text

        q5.Text = gvPreguntas.Rows(4).Cells(1).Text
        'correcta
        rb13.Text = gvPreguntas.Rows(4).Cells(2).Text
        rb15.Text = gvPreguntas.Rows(4).Cells(3).Text
        rb14.Text = gvPreguntas.Rows(4).Cells(4).Text

        q6.Text = gvPreguntas.Rows(5).Cells(1).Text
        'correcta
        rb16.Text = gvPreguntas.Rows(5).Cells(2).Text
        rb17.Text = gvPreguntas.Rows(5).Cells(3).Text
        rb18.Text = gvPreguntas.Rows(5).Cells(4).Text

        q7.Text = gvPreguntas.Rows(6).Cells(1).Text
        'correcta
        rb19.Text = gvPreguntas.Rows(6).Cells(2).Text
        rb21.Text = gvPreguntas.Rows(6).Cells(3).Text
        rb20.Text = gvPreguntas.Rows(6).Cells(4).Text

        q8.Text = gvPreguntas.Rows(7).Cells(1).Text
        'correcta
        rb23.Text = gvPreguntas.Rows(7).Cells(2).Text
        rb22.Text = gvPreguntas.Rows(7).Cells(3).Text
        rb24.Text = gvPreguntas.Rows(7).Cells(4).Text

        q9.Text = gvPreguntas.Rows(8).Cells(1).Text
        'correcta
        rb25.Text = gvPreguntas.Rows(8).Cells(2).Text
        rb26.Text = gvPreguntas.Rows(8).Cells(3).Text
        rb27.Text = gvPreguntas.Rows(8).Cells(4).Text

        q10.Text = gvPreguntas.Rows(9).Cells(1).Text
        'correcta
        rb30.Text = gvPreguntas.Rows(9).Cells(2).Text
        rb28.Text = gvPreguntas.Rows(9).Cells(3).Text
        rb29.Text = gvPreguntas.Rows(9).Cells(4).Text

        lblFecha.Text = Now.ToString()
    End Sub

    Protected Sub btnCalificar_Click(sender As Object, e As EventArgs) Handles btnCalificar.Click
        Dim cal As Integer = 0
        ' pregunta 1'
        If rb2.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 2'
        If rb4.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 3'
        If rb9.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 4'
        If rb12.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 5'
        If rb13.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 6'
        If rb16.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 7'
        If rb19.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 8'
        If rb23.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 9'
        If rb25.Checked = True Then
            cal = cal + 1
        End If
        ' pregunta 10'
        If rb30.Checked = True Then
            cal = cal + 1
        End If


        pnlCalif.Visible = True
        lblCali.Text = cal
        lblFallas.Text = 10 - cal
        lblAciertos.Text = cal
        pnlExam.Visible = False


    End Sub
  
    Protected Sub btnAceptar_Click(sender As Object, e As EventArgs) Handles btnAceptar.Click
        SqlExamen.Insert()
        Response.Redirect("~/Cursos/Examen.aspx")
    End Sub
End Class