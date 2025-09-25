global class NightlyStockJob implements Schedulable {
    global void execute(SchedulableContext sc) {
        // run batch with size 200
        Database.executeBatch(new RecalculateStockBatch(), 200);
    }
}
