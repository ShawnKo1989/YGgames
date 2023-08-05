package test;

public class Abcd {
 public static void main(String[] args) {
	String str = "123,000";
	str = str.replaceAll("[,]","");
	int a = Integer.parseInt(str);
	System.out.println(a);
}
}
