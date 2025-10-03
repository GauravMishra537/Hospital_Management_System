package hospital.management.system;

import net.proteanit.sql.DbUtils;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;

public class ALL_Patient_Info extends JFrame {
    JTable table;

    ALL_Patient_Info() {
        JPanel panel = new JPanel();
        panel.setBounds(5, 5, 890, 590);
        panel.setBackground(new Color(90, 156, 163));
        panel.setLayout(null);
        add(panel);

        table = new JTable();
        table.setBounds(10, 40, 880, 450);
        table.setBackground(new Color(90, 156, 163));
        table.setFont(new Font("Tahoma", Font.BOLD, 12));
        panel.add(table);

        // Call reusable method to load data
        loadPatientData();

        JLabel label1 = new JLabel("ID");
        label1.setBounds(20, 11, 50, 14);
        label1.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label1);

        JLabel label2 = new JLabel("Number");
        label2.setBounds(80, 11, 100, 14);
        label2.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label2);

        JLabel label3 = new JLabel("Name");
        label3.setBounds(180, 11, 100, 14);
        label3.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label3);

        JLabel label4 = new JLabel("Gender");
        label4.setBounds(300, 11, 100, 14);
        label4.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label4);

        JLabel label5 = new JLabel("Disease");
        label5.setBounds(400, 11, 100, 14);
        label5.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label5);

        JLabel label6 = new JLabel("Room");
        label6.setBounds(500, 11, 100, 14);
        label6.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label6);

        JLabel label7 = new JLabel("Admit Date");
        label7.setBounds(580, 11, 100, 14);
        label7.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label7);

        JLabel label8 = new JLabel("Deposit");
        label8.setBounds(690, 11, 100, 14);
        label8.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label8);

        JLabel label9 = new JLabel("Status");
        label9.setBounds(800, 11, 100, 14);
        label9.setFont(new Font("Tahoma", Font.BOLD, 14));
        panel.add(label9);

        JButton refreshBtn = new JButton("REFRESH");
        refreshBtn.setBounds(300, 510, 120, 30);
        refreshBtn.setBackground(Color.black);
        refreshBtn.setForeground(Color.white);
        panel.add(refreshBtn);

        refreshBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loadPatientData();
            }
        });

        JButton backBtn = new JButton("BACK");
        backBtn.setBounds(450, 510, 120, 30);
        backBtn.setBackground(Color.black);
        backBtn.setForeground(Color.white);
        panel.add(backBtn);

        backBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                setVisible(false);
                new Reception();
            }
        });

        setUndecorated(true);
        setSize(900, 600);
        setLayout(null);
        setLocation(300, 200);
        setVisible(true);
    }

    // Method to reload data
    private void loadPatientData() {
        try {
            conn c = new conn();
            String q = "SELECT patient_id AS ID, number, name, gender, disease, room_no AS Room, " +
                    "admit_date AS `Admit Date`, deposit, " +
                    "CASE WHEN discharge_date IS NULL THEN 'Admitted' ELSE 'Discharged' END AS Status " +
                    "FROM patient_info";
            ResultSet resultSet = c.statement.executeQuery(q);
            table.setModel(DbUtils.resultSetToTableModel(resultSet));
        } catch (Exception e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "Error loading patient data: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        new ALL_Patient_Info();
    }
}
