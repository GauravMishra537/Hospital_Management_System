package hospital.management.system;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class patient_discharge extends JFrame implements ActionListener {

    Choice cPatient;
    JLabel lblName, lblRoom, lblAdmitDate, lblDeposit, lblPrice, lblDays, lblTotal;
    JButton dischargeBtn, backBtn;

    public patient_discharge() {
        JPanel panel = new JPanel();
        panel.setBounds(5, 5, 750, 500);
        panel.setBackground(new Color(90, 156, 163));
        panel.setLayout(null);
        add(panel);

        JLabel title = new JLabel("DISCHARGE PATIENT");
        title.setBounds(220, 10, 300, 40);
        title.setFont(new Font("Tahoma", Font.BOLD, 22));
        title.setForeground(Color.BLACK);
        panel.add(title);

        JLabel l1 = new JLabel("Select Patient No:");
        l1.setBounds(50, 80, 150, 30);
        panel.add(l1);

        cPatient = new Choice();
        cPatient.setBounds(200, 80, 150, 25);
        panel.add(cPatient);

        JLabel l2 = new JLabel("Name:");
        l2.setBounds(50, 120, 150, 30);
        panel.add(l2);

        lblName = new JLabel();
        lblName.setBounds(200, 120, 200, 30);
        panel.add(lblName);

        JLabel l3 = new JLabel("Room No:");
        l3.setBounds(50, 160, 150, 30);
        panel.add(l3);

        lblRoom = new JLabel();
        lblRoom.setBounds(200, 160, 200, 30);
        panel.add(lblRoom);

        JLabel l4 = new JLabel("Admit Date:");
        l4.setBounds(50, 200, 150, 30);
        panel.add(l4);

        lblAdmitDate = new JLabel();
        lblAdmitDate.setBounds(200, 200, 200, 30);
        panel.add(lblAdmitDate);

        JLabel l5 = new JLabel("Deposit:");
        l5.setBounds(50, 240, 150, 30);
        panel.add(l5);

        lblDeposit = new JLabel();
        lblDeposit.setBounds(200, 240, 200, 30);
        panel.add(lblDeposit);

        JLabel l6 = new JLabel("Room Price:");
        l6.setBounds(50, 280, 150, 30);
        panel.add(l6);

        lblPrice = new JLabel();
        lblPrice.setBounds(200, 280, 200, 30);
        panel.add(lblPrice);

        JLabel l7 = new JLabel("Days Stayed:");
        l7.setBounds(50, 320, 150, 30);
        panel.add(l7);

        lblDays = new JLabel();
        lblDays.setBounds(200, 320, 200, 30);
        panel.add(lblDays);

        JLabel l8 = new JLabel("Total Bill:");
        l8.setBounds(50, 360, 150, 30);
        panel.add(l8);

        lblTotal = new JLabel();
        lblTotal.setBounds(200, 360, 200, 30);
        panel.add(lblTotal);

        dischargeBtn = new JButton("DISCHARGE");
        dischargeBtn.setBounds(150, 420, 150, 30);
        dischargeBtn.setBackground(Color.BLACK);
        dischargeBtn.setForeground(Color.WHITE);
        panel.add(dischargeBtn);

        backBtn = new JButton("BACK");
        backBtn.setBounds(350, 420, 150, 30);
        backBtn.setBackground(Color.BLACK);
        backBtn.setForeground(Color.WHITE);
        panel.add(backBtn);

        loadPatients();

        cPatient.addItemListener(e -> loadPatientDetails(cPatient.getSelectedItem()));
        dischargeBtn.addActionListener(this);
        backBtn.addActionListener(this);

        setUndecorated(true);
        setSize(760, 520);
        setLayout(null);
        setLocation(300, 200);
        setVisible(true);
    }

    private void loadPatients() {
        cPatient.removeAll();
        try {
            conn c = new conn();
            ResultSet rs = c.statement.executeQuery("SELECT number FROM patient_info WHERE discharge_date IS NULL");
            while (rs.next()) {
                cPatient.add(rs.getString("number"));
            }
            if (cPatient.getItemCount() > 0) {
                loadPatientDetails(cPatient.getSelectedItem());
            } else {
                clearDetails();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void loadPatientDetails(String patientNo) {
        try {
            conn c = new conn();
            String q = "SELECT * FROM patient_info WHERE number='" + patientNo + "'";
            ResultSet rs = c.statement.executeQuery(q);
            if (rs.next()) {
                lblName.setText(rs.getString("name"));
                lblRoom.setText(rs.getString("room_no"));
                lblAdmitDate.setText(rs.getString("admit_date"));
                lblDeposit.setText(rs.getString("deposit"));
                lblPrice.setText(rs.getString("price"));

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date admitDate = sdf.parse(rs.getString("admit_date"));
                Date now = new Date();
                long diff = now.getTime() - admitDate.getTime();
                long days = (diff / (1000 * 60 * 60 * 24)) + 1;
                lblDays.setText(String.valueOf(days));

                double price = rs.getDouble("price");
                double deposit = rs.getDouble("deposit");
                double total = (days * price) + deposit;
                lblTotal.setText(String.valueOf(total));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void clearDetails() {
        lblName.setText("");
        lblRoom.setText("");
        lblAdmitDate.setText("");
        lblDeposit.setText("");
        lblPrice.setText("");
        lblDays.setText("");
        lblTotal.setText("");
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == dischargeBtn) {
            String patientNo = cPatient.getSelectedItem();
            if (patientNo == null || patientNo.isEmpty()) {
                JOptionPane.showMessageDialog(null, "No patient selected!");
                return;
            }

            try {
                conn c = new conn();
                ResultSet rs = c.statement.executeQuery("SELECT patient_id, room_no FROM patient_info WHERE number='" + patientNo + "'");
                if (rs.next()) {
                    int patientId = rs.getInt("patient_id");
                    String roomNo = rs.getString("room_no");

                    // ✅ Mark patient discharged
                    String q1 = "UPDATE patient_info SET discharge_date=NOW() WHERE patient_id=" + patientId;
                    c.statement.executeUpdate(q1);

                    // ✅ Insert into discharge_info
                    String q2 = "INSERT INTO discharge_info (patient_id, discharge_date, total_amount, paid_amount, note) " +
                            "VALUES (" + patientId + ", NOW(), '" + lblTotal.getText() + "', '" + lblTotal.getText() + "', 'Discharged successfully')";
                    c.statement.executeUpdate(q2);

                    // ✅ Free room
                    String q3 = "UPDATE room SET availability='Available' WHERE room_no='" + roomNo + "'";
                    c.statement.executeUpdate(q3);

                    JOptionPane.showMessageDialog(null, "Patient discharged successfully!");
                    loadPatients(); // refresh dropdown
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Error while discharging: " + ex.getMessage());
            }
        } else if (e.getSource() == backBtn) {
            setVisible(false);
        }
    }

    public static void main(String[] args) {
        new patient_discharge();
    }
}
