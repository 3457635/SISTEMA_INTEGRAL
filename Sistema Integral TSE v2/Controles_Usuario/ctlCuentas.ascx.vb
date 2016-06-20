Public Class ctlCuentas
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuadar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuadar.Click

        Dim cuenta_nombre = StrConv(txbNombre.Text, VbStrConv.ProperCase)
        If txbRango.Text = "" Then
            Dim nueva_cuenta As New conta_cuenta With {.clave = txbRango1.Text,
                                                      .cuenta = cuenta_nombre,
                                                      .rango = 1
                                                       }
            db.conta_cuentas.InsertOnSubmit(nueva_cuenta)
        Else
            If txbRango.Text = "2" Then
                Dim nueva_cuenta As New conta_cuenta With {.clave = txbRango2.Text,
                                                          .cuenta = cuenta_nombre,
                                                          .rango = 2,
                                                           .id_padre = txbCuenta1.Text}
                db.conta_cuentas.InsertOnSubmit(nueva_cuenta)
            Else
                If txbRango.Text = "3" Then
                    Dim nueva_cuenta As New conta_cuenta With {.clave = txbRango3.Text,
                                                             .cuenta = cuenta_nombre,
                                                             .rango = 3,
                                                              .id_padre = txbCuenta1.Text}
                    db.conta_cuentas.InsertOnSubmit(nueva_cuenta)
                End If
            End If
        End If
        db.SubmitChanges()
        Response.Redirect("~/Contabilidad/Flujos/Cuentas/Cuentas_Padre.aspx")
    End Sub

    

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        If DropDownList1.SelectedValue <> 0 Then
            Dim clave_cuenta = (From consulta In db.conta_cuentas
                               Where consulta.id_cuenta = DropDownList1.SelectedValue
                               Select consulta.clave, consulta.cuenta, consulta.id_cuenta).First()
            txbRango1.Text = clave_cuenta.clave.ToString()
            lblRango1.Text = clave_cuenta.cuenta.ToString() + "-"
            txbCuenta1.Text = clave_cuenta.id_cuenta
            txbRango.Text = "2"
            txbRango1.Enabled = False
            txbRango2.Enabled = True
            txbRango2.Text = ""
            lblRango2.Text = ""

        Else
            txbRango1.Enabled = True
            txbRango2.Enabled = False
            txbRango3.Enabled = False

            txbCuenta1.Text = ""
            txbRango.Text = "1"
            txbRango1.Text = ""
            txbRango2.Text = ""
            ListBox1.DataBind()
        End If

        ListBox1.Visible = False
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList2.SelectedIndexChanged
        If DropDownList2.SelectedValue <> 0 Then
            Dim clave_cuenta = (From consulta In db.conta_cuentas
                               Where consulta.id_cuenta = DropDownList2.SelectedValue
                               Select consulta.clave, consulta.cuenta, consulta.id_cuenta).First()
            txbRango2.Text = clave_cuenta.clave.ToString()
            lblRango2.Text = clave_cuenta.cuenta.ToString() + "-"
            txbCuenta1.Text = clave_cuenta.id_cuenta
            txbRango.Text = "3"
            txbRango2.Enabled = False
            txbRango3.Enabled = True

        Else
            txbRango1.Enabled = False
            txbRango2.Enabled = True
            txbRango3.Enabled = False
            txbCuenta1.Text = DropDownList1.SelectedValue
            txbRango.Text = "2"
            txbRango2.Text = ""
        End If
        ListBox1.Visible = True
    End Sub

    
    Protected Sub DropDownList2_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList2.DataBound
        Dim List As New ListItem("Seleccionar...", "0")
        DropDownList2.Items.Insert(0, List)
    End Sub
End Class