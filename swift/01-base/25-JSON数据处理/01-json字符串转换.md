let dict: [String : Any] = ["name": "Tim", "age": 18]
guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else {
    return
}

guard let jsonString = String(data: jsonData, encoding: .utf8) else {
    return
}
