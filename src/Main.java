package src;

import java.sql.*;
import java.util.Scanner;

public class Main {
    static final String DB_URL = "jdbc:mysql://localhost/assignment13?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "1234";
    static Connection conn;
    static final Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {
        try {
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            while (true) {
                searchCourse();
                System.out.println("\n");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    static void searchCourse() {
        String query1 = """
                SELECT course_id, title, credits
                FROM course
                WHERE course_id IN (
                  SELECT S.course_id
                  FROM section as S, course_dept as CD
                  WHERE (S.year, S.semester) = (?, ?)
                  ANd S.course_id = CD.course_id
                  GROUP BY S.course_id
                  HAVING COUNT(*) >= 2
                )""";
        String query2 = """
                SELECT dept_name
                FROM course_dept
                WHERE course_id = ?
                """;
        try {
            PreparedStatement pstmt1 = conn.prepareStatement(query1);
            PreparedStatement pstmt2 = conn.prepareStatement(query2);

            System.out.print("┌ 연도와 학기를 입력하세요: ");
            int year = sc.nextInt();
            String semester = sc.next();
            pstmt1.setInt(1, year);
            pstmt1.setString(2, semester);

            try (ResultSet rs1 = pstmt1.executeQuery()) {
                while (rs1.next()) {
                    String course_id = rs1.getString("course_id");
                    System.out.print("└ course_id: " + course_id);
                    System.out.print(" | title: " + rs1.getString("title"));
                    System.out.print(" | credits: " + rs1.getString("credits"));

                    System.out.print(" | dept_names: ");
                    pstmt2.setString(1, course_id);
                    try (ResultSet rs2 = pstmt2.executeQuery()) {
                        while (rs2.next()) {
                            System.out.print(rs2.getString("dept_name") + ", ");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    static void sectionTimeAndClassroom() {
        String query1 = """
                SELECT  S.course_id, C.title, S.sec_id
                FROM section as S, course as C
                WHERE (S.year, S.semester) = (?, ?)
                AND S.course_id = C.course_id
                """;
        String query2 = """
                SELECT T.day, T.start_time, T.end_time, R.building, R.room_number
                FROM rooms as R, time_slot as T
                WHERE (R.time_slot_id, R.day, R.start_time) = (T.time_slot_id, T.day, T.start_time)
                AND (R.course_id, R.sec_id, R.year, R.semester) = (?, ?, ?, ?)
                """;
        try {
            PreparedStatement pstmt1 = conn.prepareStatement(query1);
            PreparedStatement pstmt2 = conn.prepareStatement(query2);

            System.out.print("┌ 연도와 학기를 입력하세요: ");
            int year = sc.nextInt();
            String semester = sc.next();
            pstmt1.setInt(1, year);
            pstmt1.setString(2, semester);

            try (ResultSet rs1 = pstmt1.executeQuery()) {
                while (rs1.next()) {
                    String course_id = rs1.getString("course_id");
                    System.out.print("└ course_id: " + course_id);
                    System.out.print(" | title: " + rs1.getString("title"));
                    System.out.print(" | credits: " + rs1.getString("credits"));

                    System.out.print(" | dept_names: ");
                    pstmt2.setString(1, course_id);
                    try (ResultSet rs2 = pstmt2.executeQuery()) {
                        while (rs2.next()) {
                            System.out.print(rs2.getString("dept_name") + ", ");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}