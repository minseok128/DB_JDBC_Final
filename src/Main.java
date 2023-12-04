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
            int command;

            while (true) {
                System.out.print("기능: ");
                command = sc.nextInt();
                if (command == 1)
                    searchMixCourse();
                else if (command == 2)
                    sectionTimeAndClassroom();
                else if (command == 3)
                    searchProject();
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

    static void searchMixCourse() {
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
                    System.out.print("└ course id: " + course_id);
                    System.out.print(" | title: " + rs1.getString("title"));
                    System.out.print(" | credits: " + rs1.getString("credits"));

                    System.out.print(" | dept names: ");
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
                    String course_id = rs1.getString("S.course_id");
                    String sec_id = rs1.getString("S.sec_id");
                    System.out.print("└ course id: " + course_id);
                    System.out.print(" | title: " + rs1.getString("C.title"));
                    System.out.println(" | section id: " + sec_id);

                    pstmt2.setString(1, course_id);
                    pstmt2.setString(2, sec_id);
                    pstmt2.setInt(3, year);
                    pstmt2.setString(4, semester);
                    try (ResultSet rs2 = pstmt2.executeQuery()) {
                        while (rs2.next()) {
                            System.out.print("\t└ day: " + rs2.getString("T.day") + ", ");
                            System.out.print("start time: " + rs2.getString("T.start_time") + ", ");
                            System.out.print("end time: " + rs2.getString("T.end_time") + ", ");
                            System.out.print("building: " + rs2.getString("R.building") + ", ");
                            System.out.println("room no: " + rs2.getString("R.room_number"));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    static void searchProject() {
        String query1 = """
                SELECT ID, name, dept_name
                FROM student
                WHERE ID = ?
                """;
        String query2 = """
                SELECT T.course_id, C.title, T.sec_id, T.grade
                FROM takes as T, course as C
                WHERE T.course_id = C.course_id
                AND (T.ID, T.year, T.semester) = (?, ?, ?)
                """;
        String query3 = """
                SELECT P.num, P.name, P.max_score, I.name, P.score
                FROM project as P, instructor as I
                WHERE P.i_id = I.id
                AND (P.s_id, P.course_id, P.sec_id, P.year, P.semester) = (?, ?, ?, ?, ?)
                """;
        String query4 = """
                SELECT count(*), avg(score)
                FROM project
                WHERE (s_id, course_id, sec_id, year, semester) = (?, ?, ?, ?, ?)
                """;
        try {
            PreparedStatement pstmt1 = conn.prepareStatement(query1);
            PreparedStatement pstmt2 = conn.prepareStatement(query2);
            PreparedStatement pstmt3 = conn.prepareStatement(query3);
            PreparedStatement pstmt4 = conn.prepareStatement(query4);

            System.out.print("┌ 연도, 학기, 학번을 입력하세요: ");
            int year = sc.nextInt();
            String semester = sc.next();
            String s_id = sc.next();
            pstmt1.setString(1, s_id);
            pstmt2.setString(1, s_id);
            pstmt2.setInt(2, year);
            pstmt2.setString(3, semester);

            try (ResultSet rs1 = pstmt1.executeQuery()) {
                rs1.next();
                System.out.print("ID: " + rs1.getString("ID"));
                System.out.print(", name: " + rs1.getString("name"));
                System.out.println(", dept name: " + rs1.getString("dept_name"));
                try (ResultSet rs2 = pstmt2.executeQuery()) {
                    while (rs2.next()) {
                        String course_id = rs2.getString("T.course_id");
                        String sec_id = rs2.getString("T.sec_id");
                        System.out.print("\t└ course id: " + course_id);
                        System.out.print(", title: " + rs2.getString("C.title"));
                        System.out.print(", sec id: " + sec_id);
                        System.out.println(", grade: " + rs2.getString("T.grade"));

                        try {
                            // AND (P.s_id, P.course_id, P.sec_id, P.year, P.semester) = (?, ?, ?, ?, ?)
                            pstmt3.setString(1, s_id);
                            pstmt3.setString(2, course_id);
                            pstmt3.setString(3, sec_id);
                            pstmt3.setInt(4, year);
                            pstmt3.setString(5, semester);
                            try (ResultSet rs3 = pstmt3.executeQuery()) {
                                while (rs3.next()) {
                                    //P.num, P.name, P.max_score, I.name, P.score
                                    System.out.print("\t\t└ pro num: " + rs3.getString("P.num"));
                                    System.out.print(", title: " + rs3.getString("P.name"));
                                    System.out.print(", sec id: " + rs3.getString("T.sec_id"));
                                    System.out.println(", grade: " + rs3.getString("T.grade"));
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}