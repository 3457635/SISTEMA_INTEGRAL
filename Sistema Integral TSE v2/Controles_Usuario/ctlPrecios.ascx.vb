Public Class ctlPrecios
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles RadioButtonList1.SelectedIndexChanged
       
    End Sub
    Protected Sub cargar_grid()
       



    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        SqlDataSource2.SelectParameters(0).DefaultValue = ddlCliente.SelectedValue
        SqlDataSource2.SelectParameters(1).DefaultValue = RadioButtonList1.SelectedValue

        SqlDataSource2.DataBind()

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Dim sdsCotizacion As SqlDataSource = CType(e.Row.FindControl("sdsCotizacion"), SqlDataSource)
            'sdsCotizacion.SelectParameters(0).DefaultValue = e.Row.Cells(1).Text

        End If
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        
    End Sub

    Protected Sub GridView2_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs)
        If (e.CommandName = "modificarCaducidad") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            Dim row As GridViewRow = Me.GridView1.Rows(index).FindControl("GridView2")
            'Dim grid2 As New GridView()
            ' grid2 = CType(row.FindControl("GridView2"), GridView)

            Response.Redirect("~/Recepcion/Catalogos/Modificar_campos_de_cotizacion.aspx?id_cotizacion=" + row.Cells(1).Text)

            ' Add code here to add the item to the shopping cart.

        End If
    End Sub

    Protected Sub GridView3_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles GridView3.RowCommand
        If (e.CommandName = "modificar") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            Dim row As GridViewRow = GridView3.Rows(index)
            'Dim grid2 As New GridView()
            ' grid2 = CType(row.FindControl("GridView2"), GridView)

            Response.Redirect("~/Recepcion/Catalogos/Modificar_campos_de_cotizacion.aspx?id_cotizacion=" + row.Cells(2).Text)



        End If
    End Sub

    Protected Sub GridView3_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView3.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'If IsNumeric(e.Row.Cells(1).Text) Then
            If e.Row.Cells(2).Text.Equals("&nbsp;") Then
                ' HyperLink lnk = (HyperLink)e.Row.FindControl("hlPlus");
                Dim lnk As New LinkButton()
                lnk = CType(e.Row.FindControl("lnkModificar"), LinkButton)
                lnk.Visible = False

            End If
        End If
    End Sub

    
End Class