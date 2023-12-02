package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Main {
    // 데이터베이스 연결 정보
    static final String DB_URL = "jdbc:mysql://localhost/assignment13?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "1234";
    static Connection conn;
    static final Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {

        // 데이터베이스 연결
        try {
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            String QUERY_INFO = "SELECT * FROM student WHERE ID = ?";
            String QUERY_TAKE = "SELECT T.course_id, C.title, T.sec_id, T.semester, T.year, T.grade " +
                    "FROM takes AS T, course AS C " +
                    "WHERE ID = ? AND T.course_id = C.course_id";

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
        String Query1 = """
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
        String Query2 = """
                SELECT dept_name
                FROM course_dept
                WHERE course_id = ?
                """;
        try {
            PreparedStatement pstmt1 = conn.prepareStatement(Query1);
            PreparedStatement pstmt2 = conn.prepareStatement(Query2);

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