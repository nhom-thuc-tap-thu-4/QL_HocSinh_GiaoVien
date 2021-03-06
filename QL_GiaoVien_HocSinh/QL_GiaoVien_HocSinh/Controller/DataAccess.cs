﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QL_GiaoVien_HocSinh.Models
{
    class DataAccess
    {
        static readonly string constr = @"Data Source=.\sqlexpress; Initial Catalog=QL_HocSinh_GiaoVien;Integrated Security=True";
        private static SqlConnection con = new SqlConnection(constr);
        public DataTable Query(string sql, params SqlParameter[] pr)
        {
            SqlDataAdapter da = null;
            DataTable dt = new DataTable();
            con.Open();
            if (sql.Trim().Contains(' '))
                da = new SqlDataAdapter(sql, con);
            else
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.CommandType = CommandType.StoredProcedure;
                pr.ToList().ForEach(x => cmd.Parameters.Add(x));
                da = new SqlDataAdapter(cmd);
            }
            da.Fill(dt);
            con.Close();
            return dt;
        }
        public void NonQuery(string sql, params SqlParameter[] pr)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            if (sql.Trim().Contains(' '))
                cmd.CommandType = CommandType.Text;
            else
            {
                cmd.CommandType = CommandType.StoredProcedure;
                pr.ToList().ForEach(x => cmd.Parameters.Add(x));
            }
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public String LaySTT(int autoNum)
        {
            if (autoNum < 10)
                return "000" + autoNum;

            else if (autoNum >= 10 && autoNum < 100)
                return "00" + autoNum;

            else if (autoNum >= 100 && autoNum < 1000)
                return "0" + autoNum;

            else if (autoNum >= 1000 && autoNum < 10000)
                return "" + autoNum;

            else
                return "";
        }
    }
}
