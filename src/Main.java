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
    static final String PASS = "5858eoEO!";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 데이터베이스 연결
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            // 쿼리문 정의
            String QUERY_INFO = "SELECT * FROM student WHERE ID = ?";
            String QUERY_TAKE = "SELECT T.course_id, C.title, T.sec_id, T.semester, T.year, T.grade " +
                    "FROM takes AS T, course AS C " +
                    "WHERE ID = ? AND T.course_id = C.course_id";

            // PreparedStatement 생성
            try (PreparedStatement pstmt1 = conn.prepareStatement(QUERY_INFO);
                 PreparedStatement pstmt2 = conn.prepareStatement(QUERY_TAKE)) {

                // 무한 반복하여 사용자 입력 처리
                while (true) {
                    System.out.print("┌ 학번을 입력하세요 (종료하려면 'exit' 입력): ");
                    String input = scanner.nextLine();

                    // 'exit' 입력 시 종료
                    if ("exit".equalsIgnoreCase(input)) {
                        System.out.println("프로그램 종료.");
                        break;
                    }

                    // 쿼리문에 파라미터 설정
                    pstmt1.setString(1, input);
                    pstmt2.setString(1, input);

                    // 학생 정보 조회 및 출력
                    try (ResultSet rs = pstmt1.executeQuery()) {
                        if (rs.next()) {
                            System.out.print("└ 학번: " + rs.getString("ID"));
                            System.out.print(" | 이름: " + rs.getString("name"));
                            System.out.print(" | 학과: " + rs.getString("dept_name"));
                            System.out.println(" | 총 수강학점: " + rs.getString("tot_cred"));
                        } else {
                            System.out.println("해당 학번의 학생을 찾을 수 없습니다.");
                        }
                    }

                    // 수강한 과목 정보 조회 및 출력
                    try (ResultSet rs = pstmt2.executeQuery()) {
                        System.out.println("┌ 과목번호, 과목명, 분반번호, 년도, 학기, 성적");
                        while (rs.next()) {
                            System.out.print("├ " + rs.getString("T.course_id"));
                            System.out.print(", " + rs.getString("C.title"));
                            System.out.print(", " + rs.getString("T.sec_id"));
                            System.out.print(", " + rs.getString("T.year"));
                            System.out.print(", " + rs.getString("T.semester"));
                            System.out.println(", " + rs.getString("T.grade"));
                        }
                    }
                    System.out.println("\n");
                }
            }

        } catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }
    }
}