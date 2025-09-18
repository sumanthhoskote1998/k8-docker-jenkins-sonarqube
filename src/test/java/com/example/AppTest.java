package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class AppTest {

    @Test
    void testAddition() {
        assertEquals(5, 2 + 3);
    }

    @Test
    void testSubtraction() {
        assertEquals(1, 3 - 2);
    }

    @Test
    void testMultiplication() {
        assertEquals(6, 2 * 3);
    }

    @Test
    void testDivision() {
        assertEquals(2, 6 / 3);
    }
}
