package com.diu.eduplex.models;

public class MakePayment {
    private String id;
    private float amount;
    private int transactionId;
    private String userId;

    // Constructor
    public MakePayment(String id, float amount, int transactionId, String userId) {
        this.id = id;
        this.amount = amount;
        this.transactionId = transactionId;
        this.userId = userId;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    // Methods
    public void confirmTransaction() {
        // Implementation for confirming transaction
    }

    public void returnMoneyOnCancellation() {
        // Implementation for returning money on cancellation
    }
}