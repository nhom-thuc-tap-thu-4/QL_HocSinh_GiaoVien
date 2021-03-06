﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QL_GiaoVien_HocSinh.Models;
using QL_GiaoVien_HocSinh.View;
using QL_GiaoVien_HocSinh.Controller;
using System.Windows.Forms;
using QL_GiaoVien_HocSinh.Controller;

namespace QL_GiaoVien_HocSinh.View
{
    public partial class ThemHS : Form
    {
        Controllers _control = new Controllers();
        HocSinh hs= new HocSinh();
        DataGridView dataGridView;
        DataAccess da = new DataAccess();
        public ThemHS()
        {
            InitializeComponent();
        }
        public ThemHS(DataGridView _dataGridView)
        {
            InitializeComponent();
            dataGridView = _dataGridView;
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (checkThemHS())
            {
                hs.Ma = txtMaHS.Text.ToString().Trim();
                hs.Ten = txtHoTenHS.Text.ToString().Trim();
                hs.NgaySinh = DateTime.Parse(dtpNgaySinh.Value.ToShortDateString());
                if (rdbnam.Checked)
                    hs.GioiTinh = 1;
                else hs.GioiTinh = 0;
                hs.LopMa = _control.getMaLopHocPhan(cbbLop.Text.ToString().Trim()).ToString();
                hs.SoDienThoai = txtSDT.Text.ToString().Trim();
                hs.Email = txtEmail.Text.ToString().Trim();
                hs.DanToc = txtDanToc.Text.ToString().Trim();
                hs.DiaChi = txtDiaChi.Text.ToString().Trim();

                bool themhs = _control.ThemHS(hs);
                if (themhs)
                {
                    DialogResult result = MessageBox.Show("Thành công", "Thêm", MessageBoxButtons.OK,MessageBoxIcon.Information);
                    if (result == DialogResult.OK)
                    {
                        btnThoat_Click(sender, e);
                    }
                }
                else
                {
                    MessageBox.Show("Thêm Thất bại, xin bạn xem lại thao tác!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    btnThoat_Click(sender, e);
                }
            }
        }
        private bool checkThemHS()
        {

            
            if (txtHoTenHS.Text.ToString().Trim().Equals(""))
            {
                MessageBox.Show("bạn chưa nhập tên Học Sinh!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            if (cbbLop.Text.ToString().Trim().Equals(""))
            {
                MessageBox.Show("bạn chưa chọn mã lớp cho Học Sinh!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            if (txtDiaChi.Text.ToString().Trim().Equals(""))
            {
                MessageBox.Show("bạn chưa nhập Dịa chỉ!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            if (txtDanToc.Text.ToString().Trim().Equals(""))
            {
                MessageBox.Show("bạn chưa nhập Dân tộc!", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            return true;
        }

        private void ThemHS_Load(object sender, EventArgs e)
        {
            cbbLop.DataSource = _control.getMaLopHocPhan();
            txtMaHS.Text = "HS" + da.LaySTT(dataGridView.Rows.Count + 1);
        }
    }
}
